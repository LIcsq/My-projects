#!/bin/bash

# Update and install necessary packages
apt-get update -y
apt-get install -y isc-dhcp3-server

# Define the network interfaces for the DHCP server
echo 'INTERFACESv4="eth1"' > /etc/default/isc-dhcp3-server

# Configure DHCP server settings
cat <<EOT > /etc/dhcp/dhcpd.conf
# Global parameters
default-lease-time 600;
max-lease-time 7200;
log-facility local7;

# Define subnet for net1 (192.168.1.0/29 - up to 6 hosts)
subnet 192.168.1.0 netmask 255.255.255.248 {
    range 192.168.1.2 192.168.1.6;
    option routers 192.168.1.1;
    option domain-name-servers 8.8.8.8, 8.8.4.4;
}

# Define subnet for net2 (192.168.2.0/27 - up to 24 hosts)
subnet 192.168.2.0 netmask 255.255.255.224 {
    range 192.168.2.2 192.168.2.26;
    option routers 192.168.2.1;
    option domain-name-servers 8.8.8.8, 8.8.4.4;
}

# Define subnet for net3 (192.168.3.0/26 - up to 50 hosts)
subnet 192.168.3.0 netmask 255.255.255.192 {
    range 192.168.3.2 192.168.3.50;
    option routers 192.168.3.1;
    option domain-name-servers 8.8.8.8, 8.8.4.4;
}
EOT

# Restart DHCP server to apply changes
service isc-dhcp3-server restart
service isc-dhcp3-server start
