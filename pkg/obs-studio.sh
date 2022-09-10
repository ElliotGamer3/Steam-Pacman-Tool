#!/bin/ bash
#install script for the obs-studio-minimal package
#this script is meant to be run from the reinstall-pkgs.sh script
#this script will install the obs-studio-minimal package
#check if running as sudo and fail if not
if [ "$EUID" -ne 0 ]; then
    echo "Must be run as root"
    exit
fi
#install the obs-studio-minimal package
echo "Installing obs-studio-minimal..."
pacman -S obs-studio --noconfirm
echo "Finished installing obs-studio-minimal..."