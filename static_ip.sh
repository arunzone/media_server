#!/bin/bash

interface_name="enp3s0"
ip_address="192.168.1.100/24"

sudo apt install net-tools -y
sudo chmod 600 /etc/netplan/01-network-manager-all.yaml

sudo touch /etc/netplan/02-static-ip.yaml
sudo chmod 640 /etc/netplan/02-static-ip.yaml
sudo bash -c "cat >> /etc/netplan/02-static-ip.yaml << EOF
network:
  version: 2
  renderer: NetworkManager

  ethernets:
    $interface_name:
      dhcp4: false
      addresses: [$ip_address]
      nameservers:
          addresses: [8.8.8.8,8.8.4.4]
      routes:
        - to: default
          via: 192.168.1.1
EOF"

sudo chmod 600 /etc/netplan/02-static-ip.yaml
sudo netplan try

