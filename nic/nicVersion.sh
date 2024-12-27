#!/bin/bash
set -e

read -rp "Enter username: " user
read -srp "Enter password: " passwd
echo ""

for i in $(cat server); do
    echo "=== Processing host: $i ==="
    sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10  "$user@$i" 2>/dev/null '
        sorted_vmnics=$(esxcli network nic list | awk '\''{print $1}'\'' | grep ^vmnic | sort -t"c" -k2 -n)
        for j in $sorted_vmnics; do
            echo "--- $j ---"
            esxcli network nic get -n $j | grep -i "Driver:" -A2
        done
    '
    echo
done
