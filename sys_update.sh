#!/bin/bash

# Inspired @hugocotoflorez en github

set -e

# Updating packages
sudo pacman -Syyu
yay -Syu

# Saving the package list
pacman -Qe > /home/osbby/Documents/Proyectos/Dotfiles/pacman-Qe.txt
pacman -Q > /home/osbby/Documents/Proyectos/Dotfiles/pacman-Q.txt

echo "System updated!"

# Copying dotfiles
sudo python3 /home/osbby/Documents/Proyectos/Dotfiles/update.py

# Pushing changes to github
cd /home/osbby/Documents/Proyectos/Dotfiles || exit 1
sudo -u osbby /usr/local/bin/mygit.sh "Autoupdate"
