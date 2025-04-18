#!/bin/bash
# Uninstall Minikube
# Usage: ./uninstall-minikube.sh
# Level: easy

echo "[*] Stopping Minikube..."
minikube stop

echo "[*] Deleting Minikube cluster..."
minikube delete

echo "[*] Removing Minikube binary..."
sudo rm -f /usr/local/bin/minikube

echo "[+] Minikube uninstalled ✅"
