#!/bin/bash
# Install K3s (Lightweight Kubernetes)
# Usage: ./install-k3s.sh
# Level: easy

echo "[*] Installing K3s (lightweight Kubernetes)..."

curl -sfL https://get.k3s.io | sh -

echo "[+] K3s installed ✅"
echo "ℹ️  kubeconfig: /etc/rancher/k3s/k3s.yaml"
