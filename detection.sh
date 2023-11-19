#!/bin/bash

# Activate the virtual environment
source env/bin/activate

cd /home/sharath/Batman/yolov5_fire_detection/Fire_detection_app/Yolov_5_fire_detection/yolov5

# Run the Python script (detect.py) with the provided source input
if [ -z "$1" ]; then
    echo "Please provide a source input."
else
    python detect.py --source "$1" --weights ../models/best.pt --conf 0.2
fi

# Deactivate the virtual environment
deactivate

echo "Script completed successfully."
