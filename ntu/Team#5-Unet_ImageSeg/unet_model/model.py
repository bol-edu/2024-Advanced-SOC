import torch
import torch.nn as nn
import torchvision.models as models
import torch.nn.functional as F
from torchsummary import summary

class UNet(nn.Module):
    def __init__(self, in_channels, out_channels):
        super(UNet, self).__init__()
        self.channel_size1 = 8
        self.channel_size2 = 16
        self.channel_size3 = 32
        self.channel_size4 = 64
        self.channel_size5 = 128
        # Encoder
        self.enc1 = self.conv_block(in_channels, self.channel_size1)
        self.enc2 = self.conv_block(self.channel_size1, self.channel_size2)
        self.enc3 = self.conv_block(self.channel_size2, self.channel_size3)
        self.enc4 = self.conv_block(self.channel_size3, self.channel_size4)

        # Bottleneck
        self.bottleneck = self.conv_block(self.channel_size4, self.channel_size5)

        # Decoder
        self.upconv4 = nn.ConvTranspose2d(self.channel_size5, self.channel_size4, kernel_size=2, stride=2, bias=False)
        self.dec4 = self.conv_block(self.channel_size5, self.channel_size4)
        self.upconv3 = nn.ConvTranspose2d(self.channel_size4, self.channel_size3, kernel_size=2, stride=2, bias=False)
        self.dec3 = self.conv_block(self.channel_size4, self.channel_size3)
        self.upconv2 = nn.ConvTranspose2d(self.channel_size3, self.channel_size2, kernel_size=2, stride=2, bias=False)
        self.dec2 = self.conv_block(self.channel_size3, self.channel_size2)
        self.upconv1 = nn.ConvTranspose2d(self.channel_size2, self.channel_size1, kernel_size=2, stride=2, bias=False)
        self.dec1 = self.conv_block(self.channel_size2, self.channel_size1)

        # Output
        self.outconv = nn.Conv2d(self.channel_size1, out_channels, kernel_size=1)

    def conv_block(self, in_channels, out_channels):
        return nn.Sequential(
            nn.Conv2d(in_channels, out_channels, kernel_size=3, padding=1, bias=False),
            nn.BatchNorm2d(out_channels),
            nn.ReLU(inplace=True),
            nn.Conv2d(out_channels, out_channels, kernel_size=3, padding=1, bias=False),
            nn.BatchNorm2d(out_channels),
            nn.ReLU(inplace=True)
        )

    def forward(self, x):
        # Encoder
        enc1 = self.enc1(x)
        enc2 = self.enc2(F.max_pool2d(enc1, 2))
        enc3 = self.enc3(F.max_pool2d(enc2, 2))
        enc4 = self.enc4(F.max_pool2d(enc3, 2))

        # Bottleneck
        bottleneck = self.bottleneck(F.max_pool2d(enc4, 2))

        # Decoder
        dec4 = self.upconv4(bottleneck)
        dec4 = torch.cat((dec4, enc4), dim=1)
        dec4 = self.dec4(dec4)

        dec3 = self.upconv3(dec4)
        dec3 = torch.cat((dec3, enc3), dim=1)
        dec3 = self.dec3(dec3)

        dec2 = self.upconv2(dec3)
        dec2 = torch.cat((dec2, enc2), dim=1)
        dec2 = self.dec2(dec2)

        dec1 = self.upconv1(dec2)
        dec1 = torch.cat((dec1, enc1), dim=1)
        dec1 = self.dec1(dec1)

        return self.outconv(dec1)


if __name__ == '__main__':
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    model = UNet(in_channels=3, out_channels=21).to(device)
    print(model)
    summary(model, input_size=(3, 64, 64))
