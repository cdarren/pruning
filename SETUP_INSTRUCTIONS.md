# ADE20K Dataset and Model Setup Instructions

This guide will help you set up the ADE20K dataset and pre-trained models for the ACoSP pruning project.

## Steps to Prepare the Environment

### 1. Download the ADE20K Dataset
```bash
./download_ADE20K.sh
```
This script will download the ADE20K dataset from MIT's servers and extract it to the `./data` directory.

### 2. Set Up the ADE20K Dataset for ACoSP
```bash
./setup_ade20k.sh
```
This script will organize the downloaded dataset into the structure expected by the ACoSP repository:
- Creates the necessary list files for training and validation
- Sets up symbolic links to the actual data
- Copies required color and names files

### 3. Download Pre-trained Models
```bash
./download_model.sh
```
This script will download:
- ImageNet pre-trained weights for ResNet50 (used for initialization if needed)
- Pre-trained PSPNet50 model on ADE20K (the starting point for pruning)

The script attempts to download the model from ACoSP's cloud storage. If that fails, it will download the MIT Scene Parsing models as an alternative.

## Verify the Setup

After running all scripts, you should have:
1. The ADE20K dataset in `./data/ADEChallengeData2016/`
2. The symbolic links and list files in `./data/ade20k/`
3. The ImageNet pre-trained model in `./data/`
4. The ADE20K pre-trained PSPNet model in `ckpt/ade20k-pspnet50/` and linked in `logs/exp/ade20k/pspnet50/model/`

## Running the Pruning Process

Once the dataset and models are set up, you can run the pruning process using the ACoSP scripts.

For standard pruning (e.g., pruning 75% of the weights):
```bash
sh tool/train.sh ade20k pspnet50_0.75
```

This will prune the PSPNet50 model and fine-tune it on the ADE20K dataset using the configuration in `config/ade20k/ade20k_pspnet50_0.75.yaml`.

## Configuration

If needed, modify the paths in the configuration files:
- `config/ade20k/ade20k_pspnet50.yaml` (for standard training)
- `config/ade20k/ade20k_pspnet50_0.75.yaml` (for 75% pruning)

You may need to edit these configuration files to make sure they point to the correct model paths.

## Testing the Model

After training, you can test the model using:

```bash
sh tool/test.sh ade20k pspnet50_0.75
```
