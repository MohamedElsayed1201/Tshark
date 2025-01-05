#!/bin/bash

#set -x  # Enable debug mode for tracing commands
#set -v  # Enable verbose mode for tracing commands
#set -e  # Exit immediately if a command exits with a non-zero status

# Ensure required commands are installed
command -v tshark >/dev/null 2>&1 || {
    echo "Command 'tshark' not found, but can be installed with:"
    echo "sudo apt install tshark"
    echo "Please ask your administrator."
    echo "Exiting..."
    exit 1
}

# Constants
OUTPUT_DIR="$HOME/local/backups/wireshark"  # Base output directory
OUTPUT_FILE="$OUTPUT_DIR/shark.pcapng"      # Main output file

# Check if the output directory is writable
if [ ! -w "$OUTPUT_DIR" ]; then
    echo "No write permission to the directory $OUTPUT_DIR. Aborting."
    exit 1
else
    echo "Write permission confirmed for $OUTPUT_DIR."
fi

# Check if the OUTPUT_DIR exists, if not create it
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR" || { echo "Failed to create directory $OUTPUT_DIR. Aborting."; exit 1; }
    echo "Created directory: $OUTPUT_DIR"
else
    echo "Directory $OUTPUT_DIR already exists."
fi

# Ensure sudo permissions are granted
if ! sudo -v; then
    echo "Sudo permission required to run tshark. Exiting..."
    exit 1
fi

# Function to read input with default values and validation
get_input() {
    local prompt="$1"
    local default="$2"
    local var

    while true; do
        # Prompt user for input with a default value
        read -r -p "$prompt [default: $default]: " var
        var="${var:-$default}"  # Use default if no input is provided
        echo "$var"
        break
    done
}

# List available interfaces using tshark
echo "Available interfaces:"
sudo tshark -D

# Prompt user for interface input
INTERFACE=$(get_input "Enter the interface name (e.g., wlp2s0)" "wlp2s0")  # Use user input or default

# Prompt user for capture filter (optional, default is "http")
FILTER=$(get_input "Enter the capture filter (e.g., http)" "http")

# Prompt user for maximum file size (optional, default is 100MB)
MAX_FILE_SIZE=$(get_input "Enter the maximum capture file size in bytes (default 100MB)" "100000000")

# Prompt user for capture time (optional, default is 120 seconds)
CAPTURE_TIME=$(get_input "Enter capture duration in seconds (default 120)" "120")

# Run tshark with the specified parameters
echo "Starting capture on interface $INTERFACE with the following settings:"
echo "Filter: $FILTER"
echo "Max file size: $MAX_FILE_SIZE bytes"
echo "Capture time: $CAPTURE_TIME seconds"
echo "Output file: $OUTPUT_FILE"

# Run tshark with the specified parameters
sudo tshark -i "$INTERFACE" -a duration:"$CAPTURE_TIME" -f "$FILTER" -w "$OUTPUT_FILE" -b filesize:$MAX_FILE_SIZE

# Done
echo "Capture complete. Packets saved to $OUTPUT_FILE"

exit 0

