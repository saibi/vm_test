#!/bin/bash
PACKAGE="wget unzip httpd"
SVC="httpd"
URL="https://www.tooplate.com/zip-templates/2098_health.zip"
ARTIFACT="2098_health"
TMPDIR="/tmp/webfiles"

# install dependencies
sudo yum install $PACKAGE -y


sudo systemctl start $SVC
sudo systemctl enable $SVC

mkdir -p $TMPDIR
cd $TMPDIR

wget $URL
unzip $ARTIFACT.zip
sudo cp -r $ARTIFACT/* /var/www/html/

# Restart httpd
sudo systemctl restart $SVC

# Cleanup
rm -rf $TMPDIR