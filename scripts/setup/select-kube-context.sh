#!/bin/bash
# Interactive kubeconfig context switcher
# Usage: ./select-kube-context.sh
# Level: easy

echo "[*] Available Kubernetes contexts:"
echo "----------------------------------------"
kubectl config get-contexts -o name | nl
echo "----------------------------------------"

read -p "Enter the number of the context to use: " index

context=$(kubectl config get-contexts -o name | sed -n "${index}p")
if [ -z "$context" ]; then
  echo "❌ Invalid selection"
  exit 1
fi

kubectl config use-context "$context"
echo "[+] Switched to context: $context ✅"
