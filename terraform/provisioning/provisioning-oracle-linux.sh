#!/usr/bin/env bash


sudo iptables -F

sudo yum update -y
sudo yum install -y docker-engine
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker $USER