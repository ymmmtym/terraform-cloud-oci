#!/usr/bin/env bash


curl https://releases.rancher.com/install-docker/20.10.sh | sh
sudo usermod -a -G docker $USER

sudo iptables -F
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo netfilter-persistent save
