#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-persistentvolume.sh <name>

[ -z "$1" ] && echo "Usage: ./create-persistentvolume.sh <name>" && exit 1

NAME="$1"

# Valeurs par défaut avec possibilité d'édition
echo -n "📦 Capacity (e.g., 1Gi) [default: 1Gi]: "
read CAPACITY
CAPACITY=${CAPACITY:-1Gi}

echo -n "💾 Storage class name (optional): "
read STORAGE_CLASS

echo -n "📁 Host path (e.g., /mnt/data): "
read HOST_PATH
if [ -z "$HOST_PATH" ]; then
  echo "❌ Host path is required."
  exit 1
fi

echo -n "🔒 Access modes (default: ReadWriteOnce): "
read ACCESS_MODES
ACCESS_MODES=${ACCESS_MODES:-ReadWriteOnce}

# Générer le YAML
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: $NAME
spec:
  capacity:
    storage: $CAPACITY
  accessModes:
    - $ACCESS_MODES
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: "$HOST_PATH"
  $( [ -n "$STORAGE_CLASS" ] && echo "storageClassName: $STORAGE_CLASS" )
EOF
