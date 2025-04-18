#!/bin/bash
# Install Minikube (Kubernetes local cluster)
# Usage: ./install-minikube.sh
# Level: easy

echo "[*] Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
echo "[+] Minikube installed ✅"
