#!/bin/ bash
#this script is meant to be run from the reinstall-pkgs.sh script
#this script is run once at the beginning of the reinstall-pkgs.sh script if
#the --init option is passed in

#check if running as sudo and fail if not
if [ "$EUID" -ne 0 ]; then
    echo "Must be run as root"
    exit
fi

#get confirmation from the user to switch out of read-only mode
echo ":::WARNING:::"
echo "This script will switch the system out of read-only mode."
echo "This will allow the system to write to the root partition."
echo "This is required for the installation of packages."
echo "Do you want to continue? (y/n)"
read -r answer
if [ "$answer" != "y"]; then
    echo "Exiting..."
    exit
fi

#switch steamos out of read-only mode
echo "Switching out of read-only mode..."
steamos-readonly disable
echo "Switched out of read-only mode."

#init the pacman keyring
echo "Initializing pacman keyring..."
pacman-key --init
echo "Initialized pacman keyring."

#populate the pacman keyring
echo "Populating pacman keyring with archlinux..."
pacman-key --populate archlinux
echo "Populated pacman keyring with archlinux."

#update and upgrade the system packages
echo "Updating and upgrading system packages..."
pacman -Syu
echo "Updated and upgraded system packages."





