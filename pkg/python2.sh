#!/bin/ bash
#install script for the python2 package
#this script is meant to be run from the reinstall-pkgs.sh script
#this script will install the python2 package
#check if running as sudo and fail if not
if [ "$EUID" -ne 0 ]; then
    echo "Must be run as root"
    exit
fi
#install the python2 package
echo "Installing python2..."
pacman -S python2 --noconfirm
echo "Finished installing python2..."