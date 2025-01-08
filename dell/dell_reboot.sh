#!/bin/bash

read -p "Please enter the username: " user
read -sp "Please enter the password: " password
echo
mapfile -t hosts < hostList.txt
read -p "Enter the number of servers to execute at a time (or 0 for all): " batch_size
failed_hosts=()
reset_server() {
    local host=$1
    sshpass -p $password ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 $user@$host serveraction powercycle
    if [[ $? -ne 0 ]]; then
        echo "Failed to reset $host"
        failed_hosts+=("$host")
    else
        echo "server reset successfully for $host"
    fi
}

if [[ $batch_size -eq 0 ]]; then
    for host in "${hosts[@]}"; do
        reset_server "$host" &
    done
    wait
else
    for ((i = 0; i < ${#hosts[@]}; i += batch_size)); do
        batch=("${hosts[@]:i:batch_size}")
        for host in "${batch[@]}"; do
            reset_server "$host" &
        done
        wait
    done
fi

if [[ ${#failed_hosts[@]} -gt 0 ]]; then
    printf "%s\n" "${failed_hosts[@]}" > failed_hosts.txt
    echo "List of failed hosts saved to failed_hosts.txt"
else
    echo "All hosts processed successfully!"
fi
