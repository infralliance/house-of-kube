#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-csidriver.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-csidriver.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

echo "⚠️ CSI Driver requires full manifest. Skipping." && exit 0
