#!/usr/bin/env bash


PRIVATE_SUBNET=$1
KUBERNETES_API_SERVER_HOSTNAME=$2
KUBERNETES_API_SERVER=$(host $KUBERNETES_API_SERVER_HOSTNAME | awk '{print $4}')

sudo apt update -y
sudo apt install -y dnsutils

sudo sysctl -w net.ipv4.ip_forward=1
sudo sed -i -e "s/^#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf

sudo iptables -F
sudo iptables -I FORWARD 1 -i ens3 -o ens3 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o ens3 -s $PRIVATE_SUBNET -j MASQUERADE

sudo iptables -t nat -A PREROUTING -p tcp --dport 6443 -j DNAT --to-destination $KUBERNETES_API_SERVER:6443
sudo iptables -t nat -A POSTROUTING -p tcp -d $KUBERNETES_API_SERVER --dport 6443 -j MASQUERADE
sudo iptables -A FORWARD -p tcp ! --syn -m state --state ESTABLISHED -s $KUBERNETES_API_SERVER --sport 6443 -j ACCEPT
sudo iptables -t nat -A OUTPUT -p tcp --dport 6443 -j DNAT --to-destination $KUBERNETES_API_SERVER:6443
