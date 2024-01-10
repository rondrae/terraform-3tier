#!/bin/bash

sudo yum update -y
sudo dnf install python3 -y
sudo dnf install vim -y
sudo dnf install wget -y
sudo dnf install telnet -y
sudo dnf install epel-release -y
sudo dnf install htop -y
sudo dnf install nginx -y

sudo systemctl start nginx
sudo systemctl enable nginx



sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload