#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-persistentvolumeclaim.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-persistentvolumeclaim.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

echo -n "📦 Storage request (e.g., 1Gi) [default: 1Gi]: "
read STORAGE
STORAGE=${STORAGE:-1Gi}

echo -n "🔒 Access modes (e.g., ReadWriteOnce) [default: ReadWriteOnce]: "
read ACCESS_MODE
ACCESS_MODE=${ACCESS_MODE:-ReadWriteOnce}

echo -n "💾 Storage class name (leave empty for default): "
read STORAGE_CLASS

# Générer le YAML et appliquer
cat <<EOF | kubectl apply -n "$NS" -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: $NAME
spec:
  accessModes:
    - $ACCESS_MODE
  resources:
    requests:
      storage: $STORAGE
  $( [ -n "$STORAGE_CLASS" ] && echo "storageClassName: $STORAGE_CLASS" )
EOF
