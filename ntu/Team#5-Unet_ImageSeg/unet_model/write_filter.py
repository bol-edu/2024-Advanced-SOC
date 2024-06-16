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

    filters = [model.enc1, model.enc2, model.enc3, model.enc4, model.bottleneck, model.upconv4, model.dec4, model.upconv3, model.dec3, model.upconv2, model.dec2, model.upconv1, model.dec1, model.outconv]
    text_filters = [f"enc1", f"enc2", f"enc3", f"enc4", f"bottleneck", f"upconv4", f"dec4", f"upconv3", f"dec3", f"upconv2", f"dec2", f"upconv1", f"dec1", f"outconv"]
    with open("filter.h", "w") as f:
        f.write("#ifndef FILTER_H\n")
        f.write("#define FILTER_H\n")
        f.write("\n")
        

        filter_count = 0

        in_channels = 3
        out_channels = 21
        channel_size1 = 8
        channel_size2 = 16
        channel_size3 = 32
        channel_size4 = 64
        channel_size5 = 128
        enc1_count = in_channels * channel_size1 * 3 * 3 + channel_size1 * channel_size1 * 3 * 3
        enc2_count = channel_size1 * channel_size2 * 3 * 3 + channel_size2 * channel_size2 * 3 * 3
        enc3_count = channel_size2 * channel_size3 * 3 * 3 + channel_size3 * channel_size3 * 3 * 3
        enc4_count = channel_size3 * channel_size4 * 3 * 3 + channel_size4 * channel_size4 * 3 * 3
        bottleneck_count = channel_size4 * channel_size5 * 3 * 3 + channel_size5 * channel_size5 * 3 * 3
        upconv4_count = channel_size5 * channel_size4 * 2 * 2
        dec4_count = channel_size5 * channel_size4 * 3 * 3 + channel_size4 * channel_size4 * 3 * 3
        upconv3_count = channel_size4 * channel_size3 * 2 * 2
        dec3_count = channel_size4 * channel_size3 * 3 * 3 + channel_size3 * channel_size3 * 3 * 3
        upconv2_count = channel_size3 * channel_size2 * 2 * 2
        dec2_count = channel_size3 * channel_size2 * 3 * 3 + channel_size2 * channel_size2 * 3 * 3
        upconv1_count = channel_size2 * channel_size1 * 2 * 2
        dec1_count = channel_size2 * channel_size1 * 3 * 3 + channel_size1 * channel_size1 * 3 * 3
        outconv_count = channel_size1 * out_channels * 1 * 1
        counts = [enc1_count, enc2_count, enc3_count, enc4_count, bottleneck_count, upconv4_count, dec4_count, upconv3_count, dec3_count, upconv2_count, dec2_count, upconv1_count, dec1_count, outconv_count]
        f.write("float filters_pretrain[" + str(sum(counts)) + "] = {" + "\n")
        for (i,filter) in enumerate(filters):
            if isinstance(filter, nn.ConvTranspose2d) or isinstance(filter, nn.Conv2d):
                w_data = filter.weight.detach().cpu().numpy()
                w_data = w_data.flatten()
                w_data.astype(np.float16)
                w_data.tofile(f, sep=", ", format="%f")
                filter_count += len(w_data)
                f.write(",\n")
                this_count = len(w_data)
                if counts[i] != this_count:
                    print(f"Error: Expected {counts[i]} but got {this_count}")

            else:
                this_count = 0
                for layer in filter: 
                    if isinstance(layer, nn.Conv2d) or isinstance(layer, nn.ConvTranspose2d):
                        w_data = layer.weight.detach().cpu().numpy()
                        w_data = w_data.flatten()
                        w_data.astype(np.float16)
                        w_data.tofile(f, sep=", ", format="%f")
                        filter_count += len(w_data)
                        f.write(",\n")
                        this_count += len(w_data)
                if counts[i] != this_count:
                    print(f"Error: Expected {counts[i]} but got {this_count}")
                    
        f.write("};\n")
        f.write("\n")
        print(f"Total filter count: {filter_count}")  

        gamma_count = (channel_size1 + channel_size2 + channel_size3 + channel_size4) * 4 + channel_size5 * 2
        print(f"Gamma count: {gamma_count}")

        f.write("float gamma_pretrain[" + str(gamma_count) + "] = {")
        gamma_len = 0
        for (i,filter) in enumerate(filters):
            if isinstance(filter, nn.Sequential):
                for layer in filter:
                    if isinstance(layer, nn.BatchNorm2d):
                        w_data = layer.weight.detach().cpu().numpy()
                        w_data.astype(np.float16)
                        w_data.tofile(f, sep=", ", format="%f")
                        f.write(",\n")
                        gamma_len += len(w_data)

        print(f"Gamma length: {gamma_len}")
        f.write("};\n")


        f.write("float beta_pretrain[" + str(gamma_count) + "] = {")
        beta_len = 0
        for (i,filter) in enumerate(filters):
            if isinstance(filter, nn.Sequential):
                for layer in filter:
                    if isinstance(layer, nn.BatchNorm2d):
                        w_data = layer.bias.detach().cpu().numpy()
                        w_data.astype(np.float16)
                        w_data.tofile(f, sep=", ", format="%f")
                        f.write(",\n")
                        beta_len += len(w_data)
        print(f"Beta length: {beta_len}")
        f.write("};\n")



        f.write("#endif\n")
    
         