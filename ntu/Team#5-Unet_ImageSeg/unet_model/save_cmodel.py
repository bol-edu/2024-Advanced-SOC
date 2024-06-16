import os
import argparse
import numpy as np
import torch
import torch.nn as nn
from model import UNet

# Define argument parser
def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--model_dir', type=str, default='./model')
    parser.add_argument('--output_dir', type=str, default='./cmodel')
    return parser.parse_args()

def save_Conv2d(file, layer):
    with open(file, 'w') as f:
        # shape: (Cout, Cin, H, W)
        w_data = layer.weight.detach().cpu().numpy()
        Cout, Cin, _, _ = w_data.shape
        print(w_data.shape)
        #print(w_data)
        for i in range(Cout):
            for j in range(Cin):
                np.savetxt(f, w_data[i][j])

def save_ConvTranspose2d(file, layer):
    with open(file, 'w') as f:
        # shape: (Cin, Cout, H, W)
        w_data = layer.weight.detach().cpu().numpy()
        Cin, Cout, _, _ = w_data.shape
        for i in range(Cin):
            for j in range(Cout):
                np.savetxt(f, w_data[i][j])

def save_BatchNorm2d(file, layer):
    with open(file, 'w') as f:
        # shape: (C, )
        w_data = layer.weight.detach().cpu().numpy()
        np.savetxt(f, w_data)

def save_layer(save_path, id, layer):
    if isinstance(layer, nn.Conv2d):
        file = os.path.join(save_path, f'{id}_Conv2d.txt')
        save_Conv2d(file, layer)
    elif isinstance(layer, nn.ConvTranspose2d):
        file = os.path.join(save_path, f'{id}_ConvTranspose2d.txt')
        save_ConvTranspose2d(file, layer)
    elif isinstance(layer, nn.BatchNorm2d):
        file = os.path.join(save_path, f'{id}_BatchNorm2d.txt')
        save_BatchNorm2d(file, layer)


if __name__ == "__main__":
    args = parse_args()

    # load PyTorch model
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    model = UNet(in_channels=3, out_channels=21).to(device)
    model.load_state_dict(torch.load(os.path.join(args.model_dir, 'unet.pth'), map_location=device))

    # set output directory
    cmodel_save_dir = args.output_dir
    os.makedirs(cmodel_save_dir, exist_ok=True)

    # Export cmodel
    save_path = os.path.join(cmodel_save_dir, 'enc1')
    os.makedirs(save_path, exist_ok=True)
    for id, layer in enumerate(model.enc1):
        save_layer(save_path, id, layer)
    
    save_path = os.path.join(cmodel_save_dir, 'enc2')
    os.makedirs(save_path, exist_ok=True)
    for id, layer in enumerate(model.enc2):
        save_layer(save_path, id, layer)

    save_path = os.path.join(cmodel_save_dir, 'enc3')
    os.makedirs(save_path, exist_ok=True)
    for id, layer in enumerate(model.enc3):
        save_layer(save_path, id, layer)

    save_path = os.path.join(cmodel_save_dir, 'enc4')
    os.makedirs(save_path, exist_ok=True)
    for id, layer in enumerate(model.enc4):
        save_layer(save_path, id, layer)
    
    save_path = os.path.join(cmodel_save_dir, 'bottleneck')
    os.makedirs(save_path, exist_ok=True)
    for id, layer in enumerate(model.bottleneck):
        save_layer(save_path, id, layer)

    save_path = os.path.join(cmodel_save_dir, 'upconv4')
    os.makedirs(save_path, exist_ok=True)
    save_layer(save_path, 0, model.upconv4)

    save_path = os.path.join(cmodel_save_dir, 'dec4')
    os.makedirs(save_path, exist_ok=True)
    for id, layer in enumerate(model.dec4):
        save_layer(save_path, id, layer)

    save_path = os.path.join(cmodel_save_dir, 'upconv3')
    os.makedirs(save_path, exist_ok=True)
    save_layer(save_path, 0, model.upconv3)

    save_path = os.path.join(cmodel_save_dir, 'dec3')
    os.makedirs(save_path, exist_ok=True)
    for id, layer in enumerate(model.dec3):
        save_layer(save_path, id, layer)

    save_path = os.path.join(cmodel_save_dir, 'upconv2')
    os.makedirs(save_path, exist_ok=True)
    save_layer(save_path, 0, model.upconv2)

    save_path = os.path.join(cmodel_save_dir, 'dec2')
    os.makedirs(save_path, exist_ok=True)
    for id, layer in enumerate(model.dec2):
        save_layer(save_path, id, layer)

    save_path = os.path.join(cmodel_save_dir, 'upconv1')
    os.makedirs(save_path, exist_ok=True)
    save_layer(save_path, 0, model.upconv1)

    save_path = os.path.join(cmodel_save_dir, 'dec1')
    os.makedirs(save_path, exist_ok=True)
    for id, layer in enumerate(model.dec1):
        save_layer(save_path, id, layer)

    save_path = os.path.join(cmodel_save_dir, 'outconv')
    os.makedirs(save_path, exist_ok=True)
    save_layer(save_path, 0, model.outconv)
