#! /bin/bash


sudo apt-get update
sudo apt-get install -y figlet

sudo rm /etc/update-motd.d/10-help-text
sudo rm /etc/update-motd.d/00-header
sudo rm /etc/update-motd.d/00-logo
sudo rm /etc/update-motd.d/01-distro
sudo rm /etc/update-motd.d/01-info

sudo cp ./00-logo /etc/update-motd.d/00-logo
sudo cp ./01-info /etc/update-motd.d/01-info


sudo chmod +x /etc/update-motd.d/00-logo
sudo chmod +x /etc/update-motd.d/01-info


cat <<EOF >> ~/.bashrc
export PS1="[\[$(tput sgr0)\]\[\033[38;5;196m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;243m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]] [\[$(tput sgr0)\]\[\033[38;5;196m\]\w\]\[\033[38;5;15m\]] \\$\[$(tput sgr0)\]"
EOF