#!/bin/bash

# Create directories
mkdir -p ./data
mkdir -p ./data/init

# Download ImageNet pre-trained weights for initialization
echo "Downloading ImageNet pre-trained ResNet50 model..."
wget -P ./data/ https://storage.googleapis.com/public-acosp-data/init/resnet50_v2.pth

# Download PSPNet50 pre-trained model on ADE20K
echo "Downloading pre-trained PSPNet50 model on ADE20K..."
mkdir -p ckpt/ade20k-pspnet50

# Check if ADE20K pre-trained model is already available in ACoSP's cloud storage
wget -P ckpt/ade20k-pspnet50 https://storage.googleapis.com/public-acosp-data/exp/ade20k/pspnet50/model/train_epoch_90.pth

# If that doesn't work, try the MIT's Scene Parsing models
if [ ! -f "ckpt/ade20k-pspnet50/train_epoch_90.pth" ]; then
  echo "Could not download from ACoSP cloud storage, trying MIT Scene Parsing models..."

  # Download MIT Scene Parsing models
  MODEL_NAME=ade20k-resnet50dilated-ppm_deepsup
  mkdir -p ckpt/$MODEL_NAME

  # Download encoder and decoder
  wget -P ckpt/$MODEL_NAME http://sceneparsing.csail.mit.edu/model/pytorch/$MODEL_NAME/encoder_epoch_20.pth
  wget -P ckpt/$MODEL_NAME http://sceneparsing.csail.mit.edu/model/pytorch/$MODEL_NAME/decoder_epoch_20.pth

  echo "Downloaded MIT Scene Parsing models. You'll need to convert these to the format expected by ACoSP."
else
  echo "Successfully downloaded pre-trained PSPNet50 model on ADE20K."
fi

# Create directory for model logs
mkdir -p logs/exp/ade20k/pspnet50/model

# Create symbolic link to ensure the model is in the expected location
ln -sf $(pwd)/ckpt/ade20k-pspnet50/train_epoch_90.pth logs/exp/ade20k/pspnet50/model/

echo "Model weights downloaded."
