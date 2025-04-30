#!/bin/bash
# Interactive script to create a ClusterRoleBinding
# Usage: ./create-clusterrolebinding.sh

read -p "<binding-name>: " BINDING_NAME
read -p "🔗 Bind to ClusterRole (name): " CLUSTERROLE
read -p "👤 Subject kind (User/Group/ServiceAccount): " SUBJECT_KIND
read -p "🔐 Subject name: " SUBJECT_NAME
read -p "[namespace for ServiceAccount only, optional]: " NS

NS_ARG=""
if [[ "$SUBJECT_KIND" == "ServiceAccount" && -n "$NS" ]]; then
  NS_ARG="--namespace=$NS"
fi

kubectl create clusterrolebinding "$BINDING_NAME" \
  --clusterrole="$CLUSTERROLE" \
  --${SUBJECT_KIND,,}="$SUBJECT_NAME" \
  $NS_ARG \
  --dry-run=client -o yaml | kubectl apply -f -

echo "✅ ClusterRoleBinding '$BINDING_NAME' created."

