#!/bin/bash
# create-role.sh - Interactive Role creator by House of Kube

set -e

# Prompt for role name
if [ -z "$1" ]; then
  read -p "📝 Enter Role name: " ROLE_NAME
else
  ROLE_NAME="$1"
fi

# Prompt for namespace
if [ -z "$2" ]; then
  read -p "📦 Enter namespace (default: default): " NAMESPACE
  NAMESPACE="${NAMESPACE:-default}"
else
  NAMESPACE="$2"
fi

# Interactive verb selection
echo "✅ Select verbs to assign (separate by spaces):"
echo "Available verbs: get list watch create update patch delete deletecollection"
read -p "🔐 Enter verbs: " -a VERBS_ARRAY

# Check verbs
if [ ${#VERBS_ARRAY[@]} -eq 0 ]; then
  echo "❌ You must provide at least one verb."
  exit 1
fi

# Prompt for resources
read -p "📚 Enter resources (default: pods): " RESOURCES
RESOURCES="${RESOURCES:-pods}"

echo "📄 Generating Role YAML for '$ROLE_NAME' in namespace '$NAMESPACE'..."

kubectl create role "$ROLE_NAME" \
  --verb="$(IFS=,; echo "${VERBS_ARRAY[*]}")" \
  --resource="$RESOURCES" \
  --dry-run=client -n "$NAMESPACE" -o yaml | kubectl apply -f -

echo "✅ Role '$ROLE_NAME' created successfully in namespace '$NAMESPACE'."

