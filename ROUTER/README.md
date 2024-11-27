

# Router Installation and Configuration

 # Introduction
The objective of this report is to document the installation and configuration process of a router in a network infrastructure environment. The router plays a critical role in facilitating network communication and ensuring connectivity between various devices. This report outlines the steps involved in setting up the router, analyzes the results of the configuration process, discusses challenges faced, lessons learned, and provides suggestions for future improvements.

# Installation and Configuration Process

1.Installing Ubuntu Server: 
https://ubuntu.com/download/server

2. Creating Network Adapters
. There were set up of two adapters for each virtual machine

Adapter 1: NAT

The first adapter is configured to use NAT (Network Address Translation). With NAT, the virtual machine shares the host's IP address and appears to external networks as if it's the host machine itself. This allows the virtual machine to access resources on external networks (like the internet) through the host machine's network connection. NAT is commonly used for outbound internet access in virtualized environments.

Adapter 2: Internal Network

The second adapter is configured to use an internal network. An internal network is a virtual network that exists only within the virtualization platform and is isolated from external networks and the host machine's network. Virtual machines connected to the same internal network can communicate with each other but cannot communicate with machines outside of the internal network or the host machine. Internal networks are often used for creating isolated environments for testing or experimentation purposes.


# Linux Router Setup

This repository contains a step-by-step guide for configuring a Linux machine as a router. The process includes setting up a DHCP server, configuring a firewall with iptables, enabling IP forwarding, and ensuring proper communication between client machines.

# Overview

This project demonstrates how to:

- Configure a machine's hostname for identification.
- Set up and configure a Dynamic Host Configuration Protocol (DHCP) server.
- Implement a firewall using iptables.
- Enable IP forwarding for packet routing.
- Test communication between client and server machines.

# Features
- Dynamic IP allocation using DHCP.
- Secure routing with iptables firewall rules.
- IP forwarding for seamless network communication.
- Static IP address configuration for persistent routing.
  
# Steps to Configure the Router

# Change Hostname
Set a hostname for easy identification:

sudo hostnamectl set-hostname router

![Picture1](https://github.com/user-attachments/assets/4869f003-4a54-4349-8a9c-7c2c3e77b95c)


# Update the /etc/hosts file:
sudo nano /etc/hosts

Modify the second line to:

127.0.0.1   router
Restart the machine to apply the new hostname.

![Picture2](https://github.com/user-attachments/assets/c0d0b8db-0bbd-4664-8f9a-2a8ddf6cd134)
# Configuring the DHCP Server
Install the DHCP server:

sudo apt update
sudo apt install isc-dhcp-server

![Picture3](https://github.com/user-attachments/assets/fa49bd04-6370-4932-9caf-62c2fbc6c153)

# Edit the dhcpd.conf file:

cd /etc/dhcp
sudo cp dhcpd.conf dhcpd.conf.backup
sudo nano dhcpd.conf

![Picture4](https://github.com/user-attachments/assets/c10cace2-0753-4571-a0f3-1c140ee8e89f)
# Add the following configuration:

ddns-update-style none;
option domain-name-servers 8.8.8.8, 8.8.4.4;
default-lease-time 600;
max-lease-time 7200;
authoritative;

subnet 20.0.0.0 netmask 255.255.255.0 {
    range 20.0.0.5 20.0.0.10;
    option routers 20.0.0.1;
}

![Picture5](https://github.com/user-attachments/assets/155cd670-80bb-4a1d-90c0-f1cf17a6a19e)

![Picture6](https://github.com/user-attachments/assets/a9f80f0a-e459-4900-83ee-0d8ace79ac72)

![Picture7](https://github.com/user-attachments/assets/911d131c-8d40-44e7-97d1-6c696e13a2e3)
# Update the /etc/default/isc-dhcp-server file to set the interface:

sudo nano /etc/default/isc-dhcp-server
Specify the interface, e.g., enp0s8.

![Picture8](https://github.com/user-attachments/assets/9fe666f7-9ca9-4072-afe9-9d78532952a7)
# Configuring the Firewall with iptables
Enable the firewall and allow DHCP communication:

sudo ufw enable
sudo ufw allow 67/udp

![Picture9](https://github.com/user-attachments/assets/4cb5cfe0-e798-4d34-bbf9-608fd93874b5)

# Apply firewall rules:

sudo iptables -A INPUT -i lo -j ACCEPT

sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

sudo iptables -P INPUT DROP

sudo iptables -P FORWARD DROP

sudo iptables -P OUTPUT ACCEPT

sudo iptables -A FORWARD -i eth0 -j ACCEPT

sudo iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE

sudo iptables -A FORWARD -i eth2 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT


![Picture10](https://github.com/user-attachments/assets/48db268c-b7fb-4356-8362-cb99b09391cb)
# Enable IP Forwarding
Edit the /etc/sysctl.conf file to enable IP forwarding:

sudo nano /etc/sysctl.conf

![Picture11](https://github.com/user-attachments/assets/db7e30ec-9ce7-4cb7-8ba4-01f7eb8512b8)
# Uncomment and modify the line:
t
net.ipv4.ip_forward = 1
# Assign Static IP to Interface
Set the IP address for the enp0s8 interface:

sudo ifconfig enp0s8 20.0.0.1
sudo ip route add 20.0.0.0/24 via 20.0.0.1
# Restart Services
Restart the network manager and DHCP server:

sudo systemctl restart NetworkManager
sudo systemctl restart isc-dhcp-server
# Testing the Setup
- Spin up client machines on the same network.
- Verify that the DHCP server assigns IP addresses (e.g., 20.0.0.5 and 20.0.0.6).
- Test communication between clients and the router using tools like ping.
