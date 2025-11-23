#!/bin/bash

files=("a" "b" "c")

mkdir -p backup #this will ensure that the backup folder is there. If it exists also, it wont give an error
for i in "${files[@]}"; do cp "$i" backup ; echo "backed up $i" ; done
