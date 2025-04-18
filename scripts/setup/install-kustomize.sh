#!/bin/bash
# Install kustomize
# Usage: ./install-kustomize.sh
# Level: easy

echo "[*] Installing kustomize..."
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
sudo mv kustomize /usr/local/bin/
echo "[+] kustomize installed ✅"
