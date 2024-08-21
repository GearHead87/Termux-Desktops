#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0; then
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

# Ensure the wheel group has sudo access
if ! grep -q "^%wheel ALL=(ALL:ALL) ALL" /etc/sudoers; then
    echo "Enabling sudo access for the wheel group..."
    echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
fi

# Add specific sudo privileges for the droidmaster user
if ! grep -q "^$username ALL=(ALL) ALL" /etc/sudoers; then
    echo "$username ALL=(ALL) ALL" >> /etc/sudoers
    echo "Sudo privileges have been granted to $username."
else
    echo "$username already has sudo privileges."
fi

echo "User $username has been created and configured."
