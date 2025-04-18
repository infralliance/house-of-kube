#!/bin/bash
# Install kubeseal (Bitnami SealedSecrets)
# Usage: ./install-kubeseal.sh
# Level: easy

echo "[*] Installing kubeseal..."
curl -Lo kubeseal https://github.com/bitnami-labs/sealed-secrets/releases/latest/download/kubeseal-linux-amd64
chmod +x kubeseal
sudo mv kubeseal /usr/local/bin/
echo "[+] kubeseal installed ✅"
