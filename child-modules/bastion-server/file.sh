#!/bin/bash

# Update apt packages
apt-get upgrade -y
apt-get update -y


# Installing Ansible
echo "Installing Ansible..."
apt-get install -y software-properties-common python-apt-common
apt install -y ansible

ec2_public_key=$(ssh-keygen -y -f ./terraform-autoscale/child-modules/bastion-server/key-folder/my-keys.pem)

echo '$ec2_public_key' > ./terraform-autoscale/child-modules/bastion-server/key-folder/my-keys.pub
