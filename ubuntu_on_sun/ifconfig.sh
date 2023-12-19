#!/bin/bash
echo "***** ifconfig enp0s8 *****"
apt install net-tools
cat >/etc/netplan/50-vagrant.yaml <<EOF
network:
  ethernets:
    enp0s8:
      addresses:
        - 172.16.5.53/23
      gateway4: 172.16.5.254
      nameservers:
        addresses:
          - 172.16.4.3
          - 172.16.4.4
          - 8.8.8.8
  version: 2
EOF
echo "***** end *****"
