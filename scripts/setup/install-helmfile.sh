#!/bin/bash
# Install helmfile
# Usage: ./install-helmfile.sh
# Level: easy

echo "[*] Installing helmfile..."
curl -Lo helmfile https://github.com/helmfile/helmfile/releases/latest/download/helmfile_Linux_amd64
chmod +x helmfile
sudo mv helmfile /usr/local/bin/
echo "[+] helmfile installed ✅"
