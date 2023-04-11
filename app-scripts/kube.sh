#!/bin/bash

if hostname | grep -qi "master"; then
    echo "Installing k3s as master";
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --disable traefik" K3S_TOKEN=${TOKEN} sh -
fi

if hostname | grep -qi "worker"; then
    echo "Joining k3s cluster as worker";
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent" K3S_TOKEN=${TOKEN} K3S_URL=https://${MASTER_IP}:6443 sh -
fi
