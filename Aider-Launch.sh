#!/bin/bash

VENV_PATH="./aider_env"
CONFIG_FILE="./.aider.conf.yml"  # Config file will be created in the current directory
SAMPLE_CONFIG="/media/mastar/Progs-Linux_250/Programs-External/Aider/aider/aider/website/assets/sample.aider.conf.yml"

# Function to display the menu
display_menu() {
    clear
    echo "================================================================================"
    echo "    Aider-Ubuntu Launc"
    echo "================================================================================"
    echo
    echo "    1. Launch Aider with aider_env"
    echo "    2. Launch Aider with DeepSeek-Coder and Gemini and aider_env"
    echo "    3. Install Aider with aider_env"
    echo "    4. Configure APT Parameters"
    echo "================================================================================"
    echo "Selection; Menu Options = 1-4, Exit Program = X:"
}

# Function to launch Aider with aider_env
launch_aider() {
    source "$VENV_PATH/bin/activate"
    aider
    deactivate
}

# Function to launch Aider with DeepSeek-Coder and Gemini
launch_aider_with_models() {
    source "$VENV_PATH/bin/activate"
    aider --model deepseek-coder --use-gemini
    deactivate
}

# Function to install Aider
install_aider() {
    python3 -m venv "$VENV_PATH"
    source "$VENV_PATH/bin/activate"
    pip install -e .
    deactivate
    echo "Aider installed successfully."
    read -p "Press Enter to continue..."
}

# Function to configure APT parameters
configure_apt() {
    if [ -f "$CONFIG_FILE" ]; then
        nano "$CONFIG_FILE"
    else
        echo "Configuration file not found in current directory."
        echo "Copying sample configuration file."
        cp "$SAMPLE_CONFIG" "$CONFIG_FILE"
        if [ $? -eq 0 ]; then
            echo "Sample configuration copied to $CONFIG_FILE."
        else
            echo "Failed to copy sample configuration."
            exit 1
        fi
        nano "$CONFIG_FILE"
    fi
}

# Main loop
while true; do
    display_menu
    read -p "Enter your choice: " choice
    
    case $choice in
        1) launch_aider ;;
        2) launch_aider_with_models ;;
        3) install_aider ;;
        4) configure_apt ;;
        [Xx]) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Press Enter to continue..."; read ;;
    esac
done
