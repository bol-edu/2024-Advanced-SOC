# UNet

## Install Necessary Packages
conda create -n asoc
conda activate asoc
pip install -r requirements.txt


## UNet profiling 

Execute the `model.py` file to profile the UNet structure

```
python model.py
```

## UNet training

Execute the `main.py` file to train UNet. 

```
python main.py --train
```

At first time execution, It need to download the dataset (download=True). 

```
# Define custom dataset
class VOC2012Dataset(Dataset):
    def __init__(self, root_dir, year='2012', image_set='train', transform=None, target_transform=None):
        self.voc = VOCSegmentation(root=root_dir, year=year, image_set=image_set, download=False)
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
```

## UNet evaluation

Execute the `main.py` file to train UNet.

```
python main.py --eval
```