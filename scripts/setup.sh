#!/bin/bash
set -e

# disable SELinux
sudo sed -i 's/SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux
sudo setenforce 0

# disable firewalld
sudo systemctl disable firewalld --now

sudo yum install epel-release -y
sudo yum install wget curl net-tools haproxy bash-completion -y

wget https://developers.redhat.com/content-gateway/rest/mirror/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz
tar -xvf crc-linux-amd64.tar.xz
sudo mv crc-linux-*/crc /usr/local/bin/
sudo chmod +x /usr/local/bin/crc

# crc setup
crc config set consent-telemetry no
crc config set disk-size 120
crc setup
crc start -p /tmp/pull-secrets

# haproxy
export CRC_IP="192.168.130.11"
export HAPROXY_IP=$(ifconfig eth0 | grep inet | grep -v inet6 | awk '{print$2}')

sudo sed -i \"s/CRC_IP/\$CRC_IP/g\" /tmp/haproxy.cfg
sudo sed -i \"s/HAPROXY_IP/\$HAPROXY_IP/g\" /tmp/haproxy.cfg

sudo mv /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg
sudo chmod 644 /etc/haproxy/haproxy.cfg
sudo systemctl enable haproxy
sudo systemctl restart haproxy
