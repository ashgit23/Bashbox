#!/bin/bash
read -rp "Enter username: " user
read -srp "Enter your password: " passwd

for i in $(cat servers); do
    sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 "$user@$i" uptime 2>/dev/null
    if [[ $? -ne 0 ]]; then
        echo "Failed to authenticate/connect to $i"
    fi
done
