#!/bin/ bash
#install script for the gnome-keyring package
#this script is meant to be run from the reinstall-pkgs.sh script
#this script will install the gnome-keyring package

#check if running as sudo and fail if not
if [ "$EUID" -ne 0 ]; then
    echo "Must be run as root"
    exit
fi

#init the gnome-keyring package
echo "Installing gnome-keyring..."
pacman -S gnome-keyring --noconfirm