#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-csinode.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-csinode.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

echo "⚠️ CSI Node is managed by kubelet. Skipping." && exit 0
