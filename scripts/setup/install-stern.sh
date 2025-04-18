#!/bin/bash
# Install stern (multi-pod log tailing)
# Usage: ./install-stern.sh
# Level: easy

echo "[*] Installing stern..."
curl -Lo stern https://github.com/stern/stern/releases/latest/download/stern_linux_amd64
chmod +x stern
sudo mv stern /usr/local/bin/
echo "[+] stern installed ✅"
