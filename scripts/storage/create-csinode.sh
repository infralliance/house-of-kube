#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-csinode.sh <name> [namespace]

set -e

# Vérification de la syntaxe
if [ -z "$1" ]; then
  echo "Usage: ./create-csinode.sh <name> [namespace]"
  exit 1
fi

NAME="$1"
NS="${2:-default}"

echo "🔧 Creating CSI Node '$NAME' in namespace '$NS'..."

# Définir le manifeste CSINode (en fonction de la configuration spécifique du nœud)
cat <<EOF | kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: CSINode
metadata:
  name: $NAME
  namespace: $NS
spec:
  drivers:
    - name: csi-driver-name
      nodeID: $NAME
      topologyKeys:
        - topology.kubernetes.io/zone
EOF

echo "✅ CSI Node '$NAME' has been created in namespace '$NS'."

