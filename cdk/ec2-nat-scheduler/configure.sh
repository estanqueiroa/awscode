#!/bin/sh
# install iptable
sudo yum install iptables-services -y
sudo systemctl enable iptables
sudo systemctl start iptables

# Turning on IP Forwarding
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Making a catchall rule for routing and masking the private IP
# Amazon Linux 2023 primay network interface is ens5
sudo iptables -t nat -A POSTROUTING -o ens5 -s 0.0.0.0/0 -j MASQUERADE
sudo /sbin/iptables -F FORWARD
sudo service iptables save