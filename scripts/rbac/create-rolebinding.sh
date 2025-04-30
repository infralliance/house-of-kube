#!/bin/bash
# Interactive script to create a RoleBinding
# Usage: ./create-rolebinding.sh

read -p "<rolebinding-name>: " RB_NAME
read -p "[namespace]: " NS
NS="${NS:-default}"
read -p "🔗 Bind to Role (name): " ROLE_NAME
read -p "👤 Subject kind (User/Group/ServiceAccount): " SUBJECT_KIND
read -p "🔐 Subject name: " SUBJECT_NAME

echo "📄 Generating RoleBinding YAML for '$RB_NAME' in namespace '$NS'..."
kubectl create rolebinding "$RB_NAME" \
  --role="$ROLE_NAME" \
  --namespace="$NS" \
  --${SUBJECT_KIND,,}="$SUBJECT_NAME" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "✅ RoleBinding '$RB_NAME' applied."

