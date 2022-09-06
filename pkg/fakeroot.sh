#!/bin/ bash
#install script for the fakeroot package
#this script is meant to be run from the reinstall-pkgs.sh script
#this script will install the fakeroot package
#check if running as sudo and fail if not
if [ "$EUID" -ne 0 ]; then
    echo "Must be run as root"
    exit
fi
#install the fakeroot package
echo "Installing fakeroot..."
pacman -S fakeroot --noconfirm
echo "Finished installing fakeroot..."