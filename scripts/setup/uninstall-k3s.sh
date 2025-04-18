#!/bin/bash
# Uninstall K3s
# Usage: ./uninstall-k3s.sh
# Level: easy

echo "[*] Uninstalling K3s..."
/usr/local/bin/k3s-uninstall.sh || /usr/bin/k3s-uninstall.sh

echo "[+] K3s uninstalled ✅"
