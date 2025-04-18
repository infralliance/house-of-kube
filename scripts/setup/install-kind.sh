#!/bin/bash
# Install kind (Kubernetes IN Docker)
# Usage: ./install-kind.sh
# Level: easy

echo "[*] Installing kind..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x kind
sudo mv kind /usr/local/bin/kind
echo "[+] kind installed ✅"
