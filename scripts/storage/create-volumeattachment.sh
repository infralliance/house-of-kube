#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-volumeattachment.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-volumeattachment.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

echo "⚠️ VolumeAttachment is node-managed. Skipping." && exit 0
