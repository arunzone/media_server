#!/bin/bash

sudo apt install openssh-server net-tools -y
sudo systemctl enable --now ssh
sudo ufw enable
sudo ufw allow ssh
sudo cp -n /etc/ssh/sshd_config /etc/ssh/sshd_config.initial
sudo add-apt-repository --yes --update ppa:deadsnakes/ppa
source input_ssh_port.sh
sudo sed -i 's/#Port 22/Port '${ssh_port_number}'/' /etc/ssh/sshd_config
sudo sed -i '/PermitRootLogin prohibit\-password/s/^#//' /etc/ssh/sshd_config
sudo sed -i '/MaxAuthTries 6/s/^#//' /etc/ssh/sshd_config
sudo sed -i '/PubkeyAuthentication yes/s/^#//' /etc/ssh/sshd_config
sudo service ssh restart

