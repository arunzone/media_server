#!/bin/bash
source ssh_server.sh
sudo sed -i 's/#Port 22/Port '${ssh_port_number}'/' /etc/ssh/sshd_config
sudo sed -i '/PermitRootLogin prohibit\-password/s/^#//' /etc/ssh/sshd_config
sudo sed -i '/MaxAuthTries 6/s/^#//' /etc/ssh/sshd_config
sudo sed -i '/PubkeyAuthentication yes/s/^#//' /etc/ssh/sshd_config
sudo service ssh restart

sudo apt --assume-yes install python3.12 python3-pip ansible
echo 'PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
ansible-galaxy collection install community.general

source ~/.bashrc

ansible-playbook -vvv -i "localhost," --ask-become-pass \
--extra-vars "ansible_user=media" \
--extra-vars "ssh_port_number=$ssh_port_number" \
-c local playbook.yml

git config --global user.email "aruncontacts@gmail.com"
git config --global user.name "Arun"
