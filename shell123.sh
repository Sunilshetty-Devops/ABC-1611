#!/bin/bash

# Define the specific location
TARGET_LOCATION="/home/sunilkumar/shell_demo"

# Prompt the user for input
read -p "Enter 0 or 1: " user_input

if [ "$user_input" == "1" ]; then
    # Create a folder and a file inside it
    FOLDER_NAME="my_folder"
    FILE_NAME="my_file.txt"

    mkdir -p "$TARGET_LOCATION/$FOLDER_NAME"
    touch "$TARGET_LOCATION/$FOLDER_NAME/$FILE_NAME"

    echo "Folder and file created at $TARGET_LOCATION/$FOLDER_NAME/$FILE_NAME"

elif [ "$user_input" == "0" ]; then
    # Delete all folders at the target location
    if [ -d "$TARGET_LOCATION" ]; then
        rm -rf "$TARGET_LOCATION"/*
        echo "All folders and files at $TARGET_LOCATION have been deleted."
    else
        echo "Target location $TARGET_LOCATION does not exist."
    fi

else
    echo "Invalid input. Please enter either 0 or 1."
    exit 1
fi

