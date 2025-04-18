#!/bin/bash
# Install kubectx and kubens
# Usage: ./install-kubectx.sh
# Level: easy

echo "[*] Installing kubectx & kubens..."
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
echo "[+] kubectx and kubens installed ✅"
