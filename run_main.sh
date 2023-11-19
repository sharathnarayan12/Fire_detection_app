#!/bin/bash

# Check if the virtual environment directory exists
if [ -d "env" ]; then
    echo "Virtual environment already set up. Skipping setup."
else
    # Run setup_environment.sh script if the virtual environment doesn't exist
    ./env_created.sh
fi

# Run activate_and_execute.sh script with the provided source input
if [ -z "$1" ]; then
    echo "Please provide a source input."
else
    ./detection.sh "$1"
    # Wait for user input (Ctrl + Z) to terminate the script
    echo "Press Ctrl + Z to end the script."
    read -r -p "" -n 1 -s
    echo "Script terminated."
    exit 0
fi
