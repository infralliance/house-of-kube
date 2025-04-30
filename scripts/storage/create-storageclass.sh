#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-storageclass.sh <name> [namespace]

set -e

# Liste des provisioners disponibles
PROVISIONERS=(
  "kubernetes.io/aws-ebs"
  "kubernetes.io/gce-pd"
  "kubernetes.io/azure-disk"
  "hostpath.csi.k8s.io"
  "kubernetes.io/no-provisioner"
  "ceph.com/rbd"
  "kubernetes.io/cinder"
  "kubernetes.io/nfs"
  "kubernetes.io/vsphere-volume"
  "pxd.portworx.com"
)

# Liste des types disponibles
TYPES=(
  "gp2"
  "io1"
  "standard"
  "premium"
  "ssd"
  "sc1"
  "st1"
  "zfs"
  "fast"
)

# Vérification de la syntaxe
if [ -z "$1" ]; then
  echo "Usage: ./create-storageclass.sh <name> [namespace]"
  exit 1
fi

NAME="$1"
NS="${2:-default}"

# Choix interactif du provisioner
echo "🧩 Select a provisioner:"
for i in "${!PROVISIONERS[@]}"; do
  echo "  $((i+1))) ${PROVISIONERS[$i]}"
done
read -p "Enter provisioner number (default 1): " prov_choice
prov_choice=${prov_choice:-1}
PROVISIONER="${PROVISIONERS[$((prov_choice-1))]}"

# Choix interactif du type
echo "💾 Select a storage type:"
for i in "${!TYPES[@]}"; do
  echo "  $((i+1))) ${TYPES[$i]}"
done
read -p "Enter type number (default 1): " type_choice
type_choice=${type_choice:-1}
TYPE="${TYPES[$((type_choice-1))]}"

echo "🔧 Creating StorageClass '$NAME' in namespace '$NS' with provisioner '$PROVISIONER' and type '$TYPE'..."

# Générer le StorageClass
cat <<EOF | kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: $NAME
provisioner: $PROVISIONER
parameters:
  type: $TYPE
EOF

echo "✅ StorageClass '$NAME' has been successfully created with provisioner '$PROVISIONER' and type '$TYPE'."

