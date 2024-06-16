import os
import time
import argparse
from pathlib import Path
import matplotlib.pyplot as plt

import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F
import torchvision.transforms as transforms
from torchvision.datasets import VOCSegmentation
from torch.utils.data import Dataset, DataLoader
from model import UNet
from PIL import Image
from tqdm import tqdm

# Define argument parser
def parse_args():
    parser = argparse.ArgumentParser()
    # training hyperparameters 
    parser.add_argument('--root_dir', type=str, default='./dataset')
    parser.add_argument('--max_epochs', type=int, default=50)
    parser.add_argument('--lr', type=float, default=1e-3)
    parser.add_argument('--batch_size', type=int, default=8)
    parser.add_argument('--model_save_dir', type=str, default='./model')
    # mode
    parser.add_argument('--eval', action="store_true", help='evaluate the model')
    parser.add_argument('--train', action="store_true", help='train the model')
    return parser.parse_args()

# Define custom dataset
class VOC2012Dataset(Dataset):
    def __init__(self, root_dir, year='2012', image_set='train', transform=None, target_transform=None):
        self.voc = VOCSegmentation(root=root_dir, year=year, image_set=image_set, download=True)
        self.transform = transform
        self.target_transform = target_transform

    def __len__(self):
        return len(self.voc)

    def __getitem__(self, idx):
        image, mask = self.voc[idx]
        
        if self.transform:
            image = self.transform(image)
        if self.target_transform:
            mask = self.target_transform(mask)
            
        return image, mask

# Data preparation function
def data_prep(args, image_set='train'):
    transform = transforms.Compose([
        transforms.Resize((64, 64)),
        transforms.ToTensor()
    ])

    target_transform = transforms.Compose([
        transforms.Resize((64, 64), interpolation=Image.NEAREST),
        transforms.ToTensor()
    ])
    dataset = VOC2012Dataset(image_set=image_set, root_dir=args.root_dir, transform=transform, target_transform=target_transform)
    dataloader = DataLoader(dataset, batch_size=args.batch_size, shuffle=True)
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

    return dataset, dataloader, device

# Validation function
def validation(args, model, criterion, valid_dataset, valid_dataloader, device):
    model.eval()
    with torch.no_grad():
        val_loss = 0.0
        val_correct = 0
        val_total = 0
        val_start_time = time.time()

        for images, masks in valid_dataloader:
            images = images.to(device)
            masks = masks.to(device).long()
            outputs = model(images)
            loss = criterion(outputs, masks.squeeze(1))
    
            _, predicted = torch.max(outputs.data, 1)
            val_total += masks.nelement()
            val_correct += (predicted == masks.squeeze(1)).sum().item()
            val_loss += loss.item()

    val_time = time.time() - val_start_time
    val_acc = val_correct / val_total
    val_loss /= len(valid_dataloader)
    
    return val_acc, val_loss, val_time

# Training function
def train(args, model, criterion, optimizer, train_dataset, train_dataloader, device):
    model.train()
    train_loss = 0.0
    train_correct = 0
    train_total = 0
    train_start_time = time.time()
    for images, masks in train_dataloader:
        images = images.to(device)
        masks = masks.to(device).long()
        
        optimizer.zero_grad()
        outputs = model(images)

        loss = criterion(outputs, masks.squeeze(1))
        loss.backward()
        optimizer.step()

        _, predicted = torch.max(outputs.data, 1)
        train_total += masks.nelement()
        train_correct += (predicted == masks.squeeze(1)).sum().item()
        train_loss += loss.item()

    train_time = time.time() - train_start_time
    train_acc = train_correct / train_total
    train_loss /= len(train_dataloader)
    
    return train_acc, train_loss, train_time

# Trainer function
def trainer(args):
    train_dataset, train_dataloader, device = data_prep(args, image_set='train')
    valid_dataset, valid_dataloader, _ = data_prep(args, image_set='val')
    print("Dataset Loaded")
    epoch = 0
    best_acc = 0.0
    model = UNet(in_channels=3, out_channels=21).to(device)
    criterion = nn.CrossEntropyLoss()
    # optimizer = optim.Adam(model.parameters(), lr=args.lr)
    optimizer = torch.optim.SGD(model.parameters(), lr=args.lr, momentum=0.9, weight_decay=1e-6)
    scheduler_step = args.max_epochs//4
    scheduler = torch.optim.lr_scheduler.MultiStepLR(optimizer, milestones=[scheduler_step, scheduler_step*2, scheduler_step*3, scheduler_step*4], gamma=0.1)

    print("Training Starting...")
    for epoch in range(args.max_epochs):
        train_acc, train_loss, train_time = train(args=args, model=model, criterion=criterion, optimizer=optimizer, train_dataset=train_dataset, train_dataloader=train_dataloader, device=device)
        print(f"{train_time:.2f} sec(s) | Epoch {epoch+1}/{args.max_epochs}, Train Acc: {train_acc:.5f}, Train Loss: {(train_loss):.5f}")

        val_acc, val_loss, val_time = validation(args=args, model=model, criterion=criterion, valid_dataset=valid_dataset, valid_dataloader=valid_dataloader, device=device)
        print(f"{val_time:.2f} sec(s) | Epoch {epoch+1}/{args.max_epochs}, Val Acc: {val_acc:.5f}, Val Loss: {(val_loss):.5f}")
        
        scheduler.step()

        is_better = val_acc > best_acc
        if is_better:
            print(f'Save best model to {args.model_save_dir} ...')
            os.makedirs(args.model_save_dir, exist_ok=True)
            torch.save(model.state_dict(), os.path.join(args.model_save_dir, 'unet.pth'))
            best_acc = val_acc
        print()

    print("Training Finished")

# Evaluation function
def evaluate(args, model, criterion, eval_dataset, eval_dataloader, device):
    model.eval()
    with torch.no_grad():
        eval_loss = 0.0
        eval_correct = 0
        eval_total = 0
        eval_start_time = time.time()
        for images, masks in eval_dataloader:
            images = images.to(device)
            masks = masks.to(device).long()
            outputs = model(images)
            loss = criterion(outputs, masks.squeeze(1))
    
            _, predicted = torch.max(outputs.data, 1)
            eval_total += masks.nelement()
            eval_correct += (predicted == masks.squeeze(1)).sum().item()
            eval_loss += loss.item()

            # Visualize the results
            # for i in range(3):
            #     plt.figure(figsize=(10, 5))
            #     plt.subplot(1, 3, 1)
            #     plt.imshow(images[i].cpu().permute(1, 2, 0))
            #     plt.title('Image')
                
            #     plt.subplot(1, 3, 2)
            #     plt.imshow(masks[i].cpu().squeeze(), cmap='gray')
            #     plt.title('Ground Truth')
                
            #     plt.subplot(1, 3, 3)
            #     plt.imshow(predicted[i].cpu(), cmap='gray')
            #     plt.title('Prediction')
            #     plt.show()
            #     plt.close()
            # break

    eval_time = time.time() - eval_start_time
    eval_acc = eval_correct / eval_total
    eval_loss /= len(eval_dataloader)
    
    print(f"Evaluation Time: {eval_time:.2f} sec(s), Acc: {eval_acc:.5f}, Loss: {eval_loss:.5f}")

# Main function
def main():
    args = parse_args()
    if args.eval:
        eval_dataset, eval_dataloader, device = data_prep(args, image_set='val')
        criterion = nn.CrossEntropyLoss()
        model = UNet(in_channels=3, out_channels=21).to(device)
        model.load_state_dict(torch.load(os.path.join(args.model_save_dir, 'unet.pth'), map_location=device))
        evaluate(args=args, model=model, criterion=criterion, eval_dataset=eval_dataset, eval_dataloader=eval_dataloader, device=device)
    elif args.train:
        trainer(args)
    else:
        print("Please specify either --train or --eval")

if __name__ == "__main__":
    main()
