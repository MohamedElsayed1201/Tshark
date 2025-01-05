# Wireshark Capture Script

This script captures network traffic on a specified interface using `tshark` and saves the capture data to a specified file. It provides an interactive way to set various capture parameters such as the network interface, capture filter, maximum file size, and capture duration.

## Prerequisites

- The script requires `tshark` to be installed. 
- `sudo` permissions are required to run `tshark`.
- The script assumes a Linux-based system.

### Installing `tshark`

If `tshark` is not installed, you can install it using the following command:

```bash
sudo apt install tshark

Usage

    Set the script executable:

    Make sure the script is executable by running the following command:

chmod +x capture_script.sh

Run the script:

Execute the script by running:

./capture_script.sh

Interactive Prompts:

When you run the script, it will prompt you for the following inputs:

    Interface name: The network interface to capture traffic on (e.g., wlp2s0). You can view available interfaces by listing them with tshark.
    Capture filter: The capture filter, such as http to capture HTTP traffic (default: http).
    Maximum capture file size: Maximum size of each capture file in bytes (default: 100MB).
    Capture duration: The duration of the capture in seconds (default: 120 seconds).

The script will also confirm if the provided directory exists and if you have write permissions to it.

Output file:

The script saves the capture to a file at:

    $HOME/local/backups/wireshark/shark.pcapng

    You can modify the OUTPUT_DIR and OUTPUT_FILE in the script if you wish to change the location or filename.

Script Details

    Dependencies:
        tshark (part of the Wireshark suite)
        sudo for elevated privileges to capture packets

    Parameters:
        INTERFACE: The network interface to capture traffic on (e.g., wlp2s0).
        FILTER: The capture filter (default: http).
        MAX_FILE_SIZE: Maximum file size in bytes (default: 100MB).
        CAPTURE_TIME: Duration of the capture in seconds (default: 120).

    Output:
        The captured network packets are saved in the .pcapng format to the file $HOME/local/backups/wireshark/shark.pcapng.

Example

Running the script:

./capture_script.sh

You'll be prompted to enter the following information:

Available interfaces:
1. eth0
2. wlp2s0

Enter the interface name (e.g., wlp2s0) [default: wlp2s0]: wlp2s0
Enter the capture filter (e.g., http) [default: http]: http
Enter the maximum capture file size in bytes (default 100MB) [default: 100000000]: 100000000
Enter capture duration in seconds (default 120) [default: 120]: 120

After entering the required details, the script will begin capturing packets on the selected interface and save them to the specified output file.
Troubleshooting

    If you see the error "Command 'tshark' not found," ensure that you have tshark installed. Run sudo apt install tshark to install it.
    If you get a "No write permission" error, ensure that the $OUTPUT_DIR directory is writable or modify the script to choose a different directory.

License

This script is provided as-is, with no warranty. You are free to modify and distribute it under your own terms.


This `README.md` provides an overview of the script's functionality, installation instructions, and how to use it interactively. Feel free to adjust any details based on your specific needs.
