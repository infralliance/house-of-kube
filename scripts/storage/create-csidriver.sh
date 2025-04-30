#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-csidriver.sh <name> [namespace]

set -e

# Vérification de la syntaxe
if [ -z "$1" ]; then
  echo "Usage: ./create-csidriver.sh <name> [namespace]"
  exit 1
fi

NAME="$1"
NS="${2:-default}"

echo "🔧 Creating CSI Driver '$NAME' in namespace '$NS'..."

# Générer le manifest pour le CSI Driver
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: $NAME
  namespace: $NS
spec:
  selector:
    matchLabels:
      app: $NAME
  template:
    metadata:
      labels:
        app: $NAME
    spec:
      containers:
        - name: $NAME
          image: <your-csi-driver-image>
          volumeMounts:
            - mountPath: /etc/provisioner/config
              name: config-volume
      volumes:
        - name: config-volume
          configMap:
            name: csi-driver-config
EOF

echo "✅ CSI Driver '$NAME' has been successfully created."

