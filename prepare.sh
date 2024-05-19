#!/bin/bash
sudo apt update && sudo apt upgrade
sudo apt install openssh-server net-tools -y
sudo systemctl enable --now ssh
sudo ufw enable
sudo ufw allow ssh
sudo cp -n /etc/ssh/sshd_config /etc/ssh/sshd_config.initial
sudo add-apt-repository --yes --update ppa:deadsnakes/ppa
sudo apt --assume-yes install python3.12 python3-pip ansible
echo 'PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
ansible-galaxy collection install community.general

source ~/.bashrc
source input_ssh_port.sh
sudo sed -i 's/#Port 22/Port '${ssh_port_number}'/' /etc/ssh/sshd_config
sudo sed -i '/PermitRootLogin prohibit\-password/s/^#//' /etc/ssh/sshd_config
sudo sed -i '/MaxAuthTries 6/s/^#//' /etc/ssh/sshd_config
sudo sed -i '/PubkeyAuthentication yes/s/^#//' /etc/ssh/sshd_config
ansible-playbook -vvv -i "localhost," --ask-become-pass \
--extra-vars "ansible_user=media" \
--extra-vars "ssh_port_number=$ssh_port_number" \
-c local playbook.yml

git config --global user.email "aruncontacts@gmail.com"
git config --global user.name "Arun"
