#!/bin/bash

# Prompt for username and password
read -rp "Please enter the username: " user
read -rsp "Please enter the password: " password
echo ""

# Prompt for the server file
read -p "Please enter the server file name (default: server): " server_file
server_file="${server_file:-server}"

# Check if the server file exists
if [[ ! -f "$server_file" ]]; then
    echo "Error: Server file '$server_file' not found."
    exit 1
fi

# Loop through each server in the file
for server in $(cat "$server_file"); do
    echo "Connecting to: $server"
    sshpass -p "$password" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 "$user@$server" \
    "smbiosDump | grep -A 4 'BIOS Info' | grep -i version" 2>/dev/null
    if [[ $? -ne 0 ]]; then
        echo "Failed to connect to $server or command error."
    fi
done
