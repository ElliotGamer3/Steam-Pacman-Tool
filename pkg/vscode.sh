#!/bin/ bash
#install script for the visual-studio-code-bin package
#this script is meant to be run from the reinstall-pkgs.sh script
#this script will install the visual-studio-code-bin package
#check if running as sudo and fail if not
if [ "$EUID" -ne 0 ]; then
    echo "Must be run as root"
    exit
fi
#install the visual-studio-code-bin package
#making temporary directory for the package
echo "Making temporary directory for the package..."
mkdir /tmp/vscode
echo "Finished making temporary directory for the package..."
#downloading the package to the temporary directory from https://aur.archlinux.org/visual-studio-code-bin.git
echo "Downloading the package from https://aur.archlinux.org/visual-studio-code-bin.git..."
git clone https://aur.archlinux.org/visual-studio-code-bin.git /tmp/vscode
echo "Finished downloading the package from https://aur.archlinux.org/visual-studio-code-bin.git..."
#check if fakeroot is installed
if ! [ -x "$(command -v fakeroot)" ]; then
    echo "Fakeroot is not installed, installing..."
    pacman -S fakeroot --noconfirm
    echo "Finished installing fakeroot..."
fi
#installing the package
echo "Installing the visual-studio-code-bin package..."
cd /tmp/vscode
makepkg -si --noconfirm
echo "Finished installing the visual-studio-code-bin package..."
#removing the temporary directory
echo "Removing the temporary directory..."
rm -rf /tmp/vscode
echo "Finished removing the temporary directory..."
#finished installing the visual-studio-code-bin package
echo "Finished installing visual-studio-code-bin..."