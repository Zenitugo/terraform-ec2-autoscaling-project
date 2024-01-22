#!/bin/bash

# Update apt packages
apt-get upgrade -y
apt-get update -y


# Installing Ansible
echo "Installing Ansible..."
apt-get install -y software-properties-common python-apt-common
apt install -y ansible

