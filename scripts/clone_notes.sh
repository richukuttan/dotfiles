#!/bin/bash

loc=$(find /mnt -maxdepth 1 -mindepth 1 -type d | grep -v wsl | grep -v c)
rsync -avh --delete /mnt/c/Users/hrish/Desktop/Notes/ $loc/Notes
