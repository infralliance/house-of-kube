#!/bin/bash
# Install arkade (Kubernetes marketplace CLI)
# Usage: ./install-arkade.sh
# Level: easy

echo "[*] Installing arkade..."
curl -sLS https://get.arkade.dev | sh
sudo mv $HOME/.arkade/bin/arkade /usr/local/bin/
echo "[+] arkade installed ✅"
