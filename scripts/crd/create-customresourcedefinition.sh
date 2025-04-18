#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-customresourcedefinition.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-customresourcedefinition.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

echo "⚠️ Creating CRDs requires a manifest. Skipping." && exit 0
