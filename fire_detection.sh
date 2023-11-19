#!/bin/bash

echo "Create a virtual environment using virtualenv"

# Check if python3-virtualenv is installed
if ! command -v virtualenv &> /dev/null; then
    # Install python3-virtualenv
    sudo apt install python3-virtualenv
fi

# Check if the virtual environment exists
if [ ! -d "env" ]; then
    # Create a virtual environment using virtualenv
    virtualenv env
    # Activate the virtual environment
    source env/bin/activate

else
    # Activate the existing virtual environment
    source env/bin/activate
fi

echo "cloneing repo..... plz wait"

# Clone the Yolov_5_fire_detection repository if it doesn't exist
if [ ! -d "Yolov_5_fire_detection" ]; then
    git clone https://github.com/sharathnarayan12/Yolov_5_fire_detection.git
    cd Yolov_5_fire_detection
fi

echo "cloning yolov5"

# Check if the yolov5 repository exists
if [ ! -d "yolov5" ]; then
    # Clone the YOLOv5 repository
    git clone https://github.com/ultralytics/yolov5
    # Change to the yolov5 directory
    cd yolov5
    # Install requirements using pip
    pip install -r requirements.txt
    echo "Environment created"
fi

# Run the Python script (detect.py) with the provided source input
if [ -z "$1" ]; then
    echo "Please provide a source input."
else
    python detect.py --source "$1" --weights ../models/best.pt --conf 0.2
fi

# No deactivation until manually interrupted (e.g., Ctrl + Z)
echo "Script completed successfully."
