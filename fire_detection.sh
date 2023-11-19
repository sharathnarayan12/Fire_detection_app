#!/bin/bash

# Specify the Python version
PYTHON_VERSION="3.8"

# Check if the virtual environment exists
if [ ! -d "env" ]; then
    # Create a virtual environment
    python${PYTHON_VERSION} -m venv env
    # Activate the virtual environment
    source env/bin/activate
    # Install requirements using pip
    pip install -r requirements.txt
else
    # Activate the existing virtual environment
    source env/bin/activate
fi

# Create a directory called fire_detection_app if it doesn't exist
mkdir -p fire_detection_app

# Change to the fire_detection_app directory
cd fire_detection_app

# Check if the yolov5 repository exists
if [ ! -d "yolov5" ]; then
    # Clone the YOLOv5 repository
    git clone https://github.com/ultralytics/yolov5
    # Change to the yolov5 directory
    cd yolov5
    # Install requirements using pip
    pip install -r requirements.txt
    # Move back to the parent directory
    cd ..
fi

# Check if the Yolov_5_fire_detection repository exists
if [ ! -d "Yolov_5_fire_detection" ]; then
    # Clone another repository (Yolov_5_fire_detection)
    git clone https://github.com/sharathnarayan12/Yolov_5_fire_detection.git
fi

# Move into the Yolov_5_fire_detection directory
cd yolov5

# Check if a source input is provided
if [ -z "$1" ]; then
    echo "Please provide a source input."
else
    # Run the Python script (detect.py) with the provided source input
    python detect.py --source "$1" --weights ../models/best.pt --conf 0.2
fi

# Deactivate the virtual environment
deactivate

echo "Environment setup and script execution completed successfully."
