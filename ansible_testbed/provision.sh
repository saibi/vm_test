#!/bin/bash

distro=$(hostnamectl | grep "Operating System" | awk '{print $3}')
echo "OS: $distro"

# create test user
sudo useradd saibi
sudo mkdir -p /home/saibi/.ssh
sudo cp /tmp/authorized_keys /home/saibi/.ssh/authorized_keys
sudo chown -R saibi:saibi /home/saibi/.ssh
sudo chmod 700 /home/saibi/.ssh
sudo chmod 600 /home/saibi/.ssh/authorized_keys

if [ "$distro" == "CentOS" ]; then
    sudo usermod -a -G wheel saibi
elif [ "$distro" == "Ubuntu" ]; then
    sudo usermod -a -G sudo saibi
fi

# install packages
if [ "$distro" == "CentOS" ]; then
    sudo yum update -y
    #sudo yum install -y wget unzip tree
elif [ "$distro" == "Ubuntu" ]; then
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
fi
