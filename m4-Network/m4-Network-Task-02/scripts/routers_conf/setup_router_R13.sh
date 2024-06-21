#!/bin/bash

set -e

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Install and configure DHCP relay
export DEBIAN_FRONTEND=noninteractive
apt-get update -yq
apt-get install -yq isc-dhcp-relay

cat <<EOT > /etc/default/isc-dhcp-relay
SERVERS="192.168.1.2"
INTERFACES="eth1 eth2"
OPTIONS=""
EOT

# Configure network interface eth2 with the IP address 192.168.3.1 using netplan
cat <<EOT > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    eth1:
      dhcp4: true
      routes:
        - to: 192.168.2.0/27
          via: 192.168.1.4
          on-link: true
        - to: 192.168.4.0/29
          via: 192.168.1.6
          on-link: true
    eth2:
      addresses:
        - 192.168.3.1/29
EOT

chmod 600 /etc/netplan/*
# Apply the netplan configuration
netplan apply

# Set up masquerading
iptables -t nat -A POSTROUTING -j MASQUERADE

# Save iptables rules to persist across reboots
# apt-get install -y iptables-persistent
# netfilter-persistent save

# Restart DHCP relay service
systemctl restart isc-dhcp-relay

systemctl restart systemd-networkd

# Check status of DHCP relay
systemctl status isc-dhcp-relay

echo "Router R1 setup completed!"

ip route del default via 10.0.2.2 dev eth0 