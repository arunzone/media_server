#!/bin/bash
sudo add-apt-repository --yes --update ppa:deadsnakes/ppa
sudo apt --assume-yes install python3.12 python3-pip
pip3 install ansible
echo 'PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

source ~/.bashrc
ansible-playbook -i "localhost," --ask-become-pass --extra-vars "ansible_user=media" -c local playbook.yml
