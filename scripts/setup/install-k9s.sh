#!/bin/bash
# Install k9s (Terminal UI for Kubernetes)
# Usage: ./install-k9s.sh
# Level: easy

echo "[*] Installing k9s..."
curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz
tar -xzf k9s.tar.gz k9s
sudo mv k9s /usr/local/bin/
rm k9s.tar.gz
echo "[+] k9s installed ✅"
