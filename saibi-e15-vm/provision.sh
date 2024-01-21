#!/bin/bash

distro=$(hostnamectl | grep "Operating System" | awk '{print $3}')
echo "OS: $distro"

# create test user
if [ "$distro" == "CentOS" ]; then
    sudo useradd saibi
    sudo usermod -a -G wheel saibi
elif [ "$distro" == "Ubuntu" ] || [ "$distro" == "Debian" ]; then
    sudo adduser --disabled-password --gecos "" saibi
    sudo usermod -a -G sudo saibi
elif [ "$distro" == "Arch" ]; then
    sudo useradd -m -G wheel saibi
fi

# create sudoers file for saibi
echo "saibi ALL=(ALL) NOPASSWD:ALL" >/tmp/saibi
sudo mv /tmp/saibi /etc/sudoers.d/saibi

# setup ssh keys
sudo mkdir -p /home/saibi/.ssh
sudo mv /tmp/authorized_keys /home/saibi/.ssh/authorized_keys
sudo mv /tmp/id_ed25519 /home/saibi/.ssh/id_ed25519
sudo chown -R saibi:saibi /home/saibi/.ssh
sudo chmod 700 /home/saibi/.ssh
sudo chmod 600 /home/saibi/.ssh/*

# install packages
if [ "$distro" == "CentOS" ]; then
    # centos stream 9
    dnf config-manager --set-enabled crb
    dnf install epel-release epel-next-release

    sudo yum update -y
    sudo yum install -y wget unzip tree
elif [ "$distro" == "Ubuntu" ]; then
    sudo apt-get update
    sudo apt-get install -y software-properties-common tree
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt-get install -y ansible
elif [ "$distro" == "Debian" ]; then
    sudo apt-get install wget gpg tree
    UBUNTU_CODENAME=jammy
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
    sudo apt-get update && sudo apt-get install ansible
elif [ "$distro" == "Arch" ]; then
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm ansible tree
fi
