#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-job.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-job.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

# Valeur par défaut pour l'image
read -p "🐳 Enter the container image (default: 'busybox'): " IMAGE
IMAGE="${IMAGE:-busybox}"

# Valeur par défaut pour la commande (optionnelle)
read -p "📥 Enter the command to run (optional, default: none): " CMD

if [ -z "$CMD" ]; then
  echo "ℹ️  No command provided, using default entrypoint from image."
  kubectl create job "$NAME" --image="$IMAGE" --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
else
  echo "ℹ️  Using custom command: $CMD"
  kubectl create job "$NAME" --image="$IMAGE" --command -- "$CMD" --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
fi

