#!/bin/bash

# Create directory structure expected by ACoSP
mkdir -p ./data/ade20k/list

# Link the downloaded ADE20K data to the expected location
if [ -d "./data/ADEChallengeData2016" ]; then
  echo "Setting up ADE20K dataset for ACoSP..."

  # Create the required list files for training and validation
  find ./data/ADEChallengeData2016/images/training -type f -name "*.jpg" | sort > ./data/ade20k/list/training.txt
  find ./data/ADEChallengeData2016/images/validation -type f -name "*.jpg" | sort > ./data/ade20k/list/validation.txt

  # Copy color and names files if they exist in the dataset
  if [ -f "./data/ADEChallengeData2016/color150.mat" ]; then
    mkdir -p ./data/ade20k
    cp ./data/ADEChallengeData2016/color150.mat ./data/ade20k/
    echo "Copied color150.mat"
  fi

  # Create symbolic links to the actual data
  ln -sf $(pwd)/data/ADEChallengeData2016/images ./data/ade20k/images
  ln -sf $(pwd)/data/ADEChallengeData2016/annotations ./data/ade20k/annotations

  echo "ADE20K dataset setup complete."
else
  echo "Error: ADE20K dataset not found. Please run download_ADE20K.sh first."
  exit 1
fi
