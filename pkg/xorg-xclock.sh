#!/bin/ bash
#install script for the xorg-xclock package
#this script is meant to be run from the reinstall-pkgs.sh script
#this script will install the xorg-xclock package
#check if running as sudo and fail if not
if [ "$EUID" -ne 0 ]; then
    echo "Must be run as root"
    exit
fi
#install the xorg-xclock package
echo "Installing xorg-xclock..."
pacman -S xorg-xclock --noconfirm