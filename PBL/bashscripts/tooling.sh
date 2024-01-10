#!/bin/bash

sudo yum update -y
sudo dnf install python3 -y
sudo dnf install vim -y
sudo dnf install wget -y
sudo dnf install telnet -y
sudo dnf install epel-release -y
sudo dnf install htop -y

sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo dnf module enable php:remi-8.2 -y
sudo dnf install php php-cli php-common -y



sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload