#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Variables
username="droidmaster"

# Create a new user and add to the wheel group
useradd -m -G wheel "$username"

# Set a password for the new user
echo "Set password for $username:"
passwd "$username"

# Add the user to sudoers
echo "$username ALL=(ALL) ALL" >> /etc/sudoers

echo "User $username has been created and granted sudo privileges."
