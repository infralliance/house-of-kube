#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-daemonset.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-daemonset.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

echo "⚠️ DaemonSet creation needs manifest or yaml. Skipping." && exit 0
