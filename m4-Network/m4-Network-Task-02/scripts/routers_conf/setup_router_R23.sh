#!/bin/bash

set -e

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Install DHCP relay
dnf install -y dhcp-relay

# Configure network interfaces using ifcfg
cat <<EOT > /etc/sysconfig/network-scripts/ifcfg-eth1
TYPE=Ethernet
BOOTPROTO=dhcp
NAME=eth1
DEVICE=eth1
ONBOOT=yes
EOT

cat <<EOT > /etc/sysconfig/network-scripts/ifcfg-eth2
TYPE=Ethernet
BOOTPROTO=none
NAME=eth2
DEVICE=eth2
ONBOOT=yes
IPADDR=192.168.2.1
NETMASK=255.255.255.224
EOT

# Restart network to apply the configuration
nmcli connection reload
nmcli connection up eth1
nmcli connection up eth2

# Set up masquerading
iptables -t nat -A POSTROUTING -j MASQUERADE

# Save iptables rules to persist across reboots
iptables-save > /etc/sysconfig/iptables

# Configure static routes
nmcli connection modify eth1 +ipv4.routes "192.168.1.0/29 192.168.1.6"
nmcli connection modify eth1 +ipv4.routes "192.168.3.0/29 192.168.1.4"
nmcli connection reload
nmcli connection up eth1

# Configure dhcrelay systemd unit
cat <<EOT > /etc/systemd/system/dhcrelay.service
[Unit]
Description=DHCP Relay Agent Daemon
Documentation=man:dhcrelay(8)
Wants=network-online.target
After=network-online.target

[Service]
Type=notify
ExecStart=/usr/sbin/dhcrelay -d --no-pid 192.168.1.2
StandardError=null

[Install]
WantedBy=multi-user.target
EOT

# Enable and start dhcrelay service
systemctl enable --now dhcrelay.service

# Delete default route
ip route del default via 10.0.2.2 dev eth0 || true

# Check status of DHCP relay
systemctl status dhcrelay

# Restart NetworkManager
systemctl restart NetworkManager

echo "Router R2 setup completed!"
