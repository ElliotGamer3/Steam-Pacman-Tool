#!/bin/ bash
#install script for the apache package
#this script is meant to be run from the reinstall-pkgs.sh script
#this script will install the apache package
#check if running as sudo and fail if not
if [ "$EUID" -ne 0 ]; then
    echo "Must be run as root"
    exit
fi
#install the apache package
echo "Installing apache..."
pacman -S apache --noconfirm
echo "Finished installing apache..."