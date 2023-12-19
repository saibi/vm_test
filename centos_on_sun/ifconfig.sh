#!/bin/bash
echo "***** ifconfig eth1 *****"
cat >/etc/sysconfig/network-scripts/ifcfg-eth1 <<EOF
BOOTPROTO=none
ONBOOT=yes
DEVICE=eth1
NM_CONTROLLED=yes
IPADDR=172.16.5.52
NETMASK=255.255.254.0
GATEWAY=172.16.5.254
DNS1=172.16.4.3
DNS2=172.16.4.4
EOF
echo "***** end *****"
sync
reboot
