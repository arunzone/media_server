#!/bin/bash
sudo apt update && sudo apt upgrade

source static_ip.sh
source ssh_server.sh

sudo apt --assume-yes install python3.12 python3-pip ansible
echo 'PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
ansible-galaxy collection install community.general

source ~/.bashrc

ansible-galaxy collection install -r requirements.yml

ansible-playbook -vvv -i "localhost," --ask-become-pass \
--extra-vars "ansible_user=media" \
--extra-vars "ssh_port_number=$ssh_port_number" \
-c local playbook.yml

git config --global user.email "aruncontacts@gmail.com"
git config --global user.name "Arun"
