#!/bin/bash

# Update the package list and upgrade packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install prerequisites and HAProxy from the specific PPA
sudo apt install --no-install-recommends software-properties-common -y
sudo apt install haproxy -y

# Create HAProxy configuration file with basic backend setup
sudo bash -c 'cat <<EOT > /etc/haproxy/haproxy.cfg
frontend fe-apiserver
    bind 0.0.0.0:6443
    mode tcp
    option tcplog
    default_backend be-apiserver

backend be-apiserver
    balance roundrobin
    mode tcp
    option tcplog
    option tcp-check
    server master1 ${server1}:6443 check
    server master2 ${server2}:6443 check
    server master3 ${server3}:6443 check
EOT'

# Restart HAProxy to apply the new configuration
sudo systemctl restart haproxy