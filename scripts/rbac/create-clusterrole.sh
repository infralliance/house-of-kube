#!/bin/bash
# Interactive script to create a ClusterRole
# Usage: ./create-clusterrole.sh

read -p "<clusterrole-name>: " ROLE_NAME

# Verbs selection
echo "✅ Select verbs to assign (space-separated, e.g., get list watch):"
echo "Available: get list watch create update patch delete deletecollection"
read -p "Enter verbs: " VERBS
if [ -z "$VERBS" ]; then
  echo "❌ No verbs provided. Aborting."
  exit 1
fi

# Resources
read -p "📚 Enter resources (default: pods): " RESOURCES
RESOURCES="${RESOURCES:-pods}"

cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: $ROLE_NAME
rules:
- apiGroups: [""]
  resources: [${RESOURCES// /,}]
  verbs: [${VERBS// /,}]
EOF

echo "✅ ClusterRole '$ROLE_NAME' created."

