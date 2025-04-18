#!/bin/bash
# Install kubectl CLI
# Usage: ./install-kubectl.sh
# Level: easy

echo "[*] Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl
echo "[+] kubectl installed ✅"
