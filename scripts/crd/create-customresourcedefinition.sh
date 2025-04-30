#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-customresourcedefinition.sh <name> [namespace]

# Vérification des arguments
if [ -z "$1" ]; then
  echo "Usage: ./create-customresourcedefinition.sh <name> [namespace]"
  exit 1
fi

NAME="$1"
NS="${2:-default}"

# Définir le groupe et le nom pluriel
GROUP="mygroup.example.com"
PLURAL="${NAME}s"  # Pluralisation simple

echo "🔧 Creating CustomResourceDefinition '$NAME' in namespace '$NS'..."

# Définir le manifeste CRD en YAML directement dans le script
cat <<EOF | kubectl apply -f -
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: $PLURAL.$GROUP
spec:
  group: $GROUP
  names:
    kind: MyCustomResource
    plural: $PLURAL
    singular: $NAME
    shortNames:
    - mcr
  scope: Namespaced
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                foo:
                  type: string
EOF

echo "✅ CustomResourceDefinition '$NAME' has been successfully created."

