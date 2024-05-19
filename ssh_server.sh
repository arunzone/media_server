#!/bin/bash

function ssh_setup() {
  sudo apt install openssh-server -y
  sudo systemctl enable ssh
  sudo systemctl enable --now ssh
  sudo ufw enable
  sudo ufw allow ssh
  sudo cp --update=none /etc/ssh/sshd_config /etc/ssh/sshd_config.initial
  sudo add-apt-repository --yes --update ppa:deadsnakes/ppa
  sudo sed -i '/PermitRootLogin prohibit\-password/s/^#//' /etc/ssh/sshd_config
  sudo sed -i '/MaxAuthTries 6/s/^#//' /etc/ssh/sshd_config
  sudo sed -i '/PubkeyAuthentication yes/s/^#//' /etc/ssh/sshd_config
  sudo ufw reload
  sudo service ssh restart
}
if [[ -f "/etc/ssh/sshd_config.initial" ]]; then
  echo "Ssh is already setup, so skipped"
else
  ssh_setup
fi

