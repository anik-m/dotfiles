#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Update System and Install Base Packages ---
echo ":: Synchronizing package databases and updating system..."
sudo pacman -Syu --noconfirm

echo ":: Installing git and base-devel for package building..."
sudo pacman -S --needed git base-devel --noconfirm

# --- Clone Dotfiles ---
# Make sure your dotfiles repository is correct
# echo ":: Cloning dotfiles from repository..."
# git clone https://github.com/your-username/your-dotfiles-repo.git ~/.dotfiles

# --- Install Stow and Manage Dotfiles ---
echo ":: Installing GNU Stow to manage dotfiles..."
sudo pacman -S stow --noconfirm

echo ":: Applying dotfiles with Stow..."
cd ~/dotfiles
stow .
cd  # Return to home directory

# --- Install Paru (AUR Helper) ---
echo ":: Installing Paru AUR Helper..."
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru # Clean up the cloned directory

# --- Install Packages ---
echo ":: Installing packages from pkglist.txt using Paru..."
cd ~/dotfiles
paru -S --noconfirm - < pkglist.txt

#install dmenu
echo ":: Installing dmenu ::"
git clone https://gitlab.com/dwt1/dmenu-distrotube.git
cd dmenu-distrotube
makepkg -cf
sudo pacman -U *.pkg.tar.zst
cd ..
rm -rf dmenu-distrotube


echo "Installation complete! Reboot for all changes to take effect."
