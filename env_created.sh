#!/bin/bash

echo "Create a virtual environment using virtualenv"

# Check the operating system
if [[ "$(uname)" == "Linux" && -e "/etc/os-release" ]]; then
    source /etc/os-release
    if [[ "$ID" == "ubuntu" || "$ID_LIKE" == "ubuntu" ]]; then
        # Ubuntu-specific commands
        echo "Ubuntu detected. Executing Ubuntu-specific commands."

        # Check if python3-virtualenv is installed
        if ! command -v virtualenv &> /dev/null; then
            # Install python3-virtualenv
            sudo apt install python3-virtualenv
        fi

        # Check if the virtual environment exists
        if [ ! -d "env" ]; then
            # Create a virtual environment using virtualenv
            virtualenv -p python3 env
            # Activate the virtual environment
            source env/bin/activate

        else
            # Activate the existing virtual environment
            source env/bin/activate
        fi

        # Rest of the script remains unchanged
    else
        # Unsupported Linux distribution
        echo "Unsupported Linux distribution. Exiting."
        exit 1
    fi
elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" || "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]]; then
    # Windows-specific commands
    echo "Windows detected. Creating Python virtualenv in Windows."

    # Check if virtualenv is installed
    if ! command -v virtualenv &> /dev/null; then
        # Install virtualenv using pip
        pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org virtualenv
    fi

    # Check if the virtual environment exists
    if [ ! -d "env" ]; then
        # Create a virtual environment using virtualenv
        virtualenv env

        echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<Activated env >>>>>>>>>>>>>>>>>>>>>>>>"
        # Activate the virtual environment
        source env/Scripts/activate


    else
        # Activate the existing virtual environment
        source env/Scripts/activate
    fi


else
    # Unsupported operating system
    echo "Unsupported operating system. Exiting."
    exit 1
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
    pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.orgl -r requirements.txt
    echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Environment created>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
else
    echo "yolov5 already exists. Skipping cloning."
fi
