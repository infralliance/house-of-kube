#!/bin/bash
# Install Helm package manager
# Usage: ./install-helm.sh
# Level: easy

echo "[*] Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
echo "[+] Helm installed ✅"
