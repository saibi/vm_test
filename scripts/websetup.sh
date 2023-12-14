#!/bin/bash

sudo yum install wget unzip httpd -y


sudo systemctl start httpd
sudo systemctl enable httpd

echo "##############################################"
echo "Starting artifact deployment..."
echo "##############################################"
mkdir -p /tmp/webfiles
cd /tmp/webfiles

wget https://www.tooplate.com/zip-templates/2098_health.zip
unzip 2098_health.zip
sudo cp -r 2098_health/* /var/www/html/

# Restart httpd
echo "##############################################"
echo "Restarting httpd..."
echo "##############################################"
sudo systemctl restart httpd

# Cleanup
echo "##############################################"
echo "Cleaning up..."
echo "##############################################"
rm -rf /tmp/webfiles