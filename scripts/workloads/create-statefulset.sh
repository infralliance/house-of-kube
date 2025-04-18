#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-statefulset.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-statefulset.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

echo "⚠️ StatefulSet creation needs a full manifest, skipping for now" && exit 0
