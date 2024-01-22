#!/bin/bash
# Create files
mkdir -p /home/ubuntu/html
cd /home/ubuntu/html
touch /home/ubuntu/html/index.html.j2

hostnames=$(hostname)
echo "<h1>Welcome to $hostnames server</h1>" > /home/ubuntu/html/index.html.j2