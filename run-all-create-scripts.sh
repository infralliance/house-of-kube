#!/bin/bash
# Smart runner for all create-*.sh scripts with default values where needed

ROOT_DIR="$(dirname "$0")/scripts"
NAMESPACE="test"

echo "🚀 Running all create-* scripts with dynamic resource names and smart defaults"
echo "📛 Namespace: $NAMESPACE"
echo "--------------------------------------"

kubectl get ns test >/dev/null 2>&1 || kubectl create ns test

find "$ROOT_DIR" -type f -name 'create-*.sh' | sort | while read -r script; do
  FILENAME="$(basename "$script")"
  RESOURCE_NAME="${FILENAME%.sh}"

  echo
  echo "🛠️ Script: $script"
  echo "🔤 Resource name: $RESOURCE_NAME"
  echo "--------------------------"

  CMD="$script "$RESOURCE_NAME""

  # Handle special cases requiring extra arguments
  case "$FILENAME" in
    create-deployment.sh)
      CMD="$script "$RESOURCE_NAME" "$NAMESPACE" --image=nginx"
      ;;
    create-job.sh)
      CMD="$script "$RESOURCE_NAME" "$NAMESPACE" --image=busybox"
      ;;
    create-cronjob.sh)
      CMD="$script "$RESOURCE_NAME" "$NAMESPACE" --schedule="*/1 * * * *" --image=busybox"
      ;;
    create-service.sh)
      CMD="$script "$RESOURCE_NAME" "$NAMESPACE" --tcp=80:80"
      ;;
    create-role.sh)
      CMD="$script "$RESOURCE_NAME" "$NAMESPACE" --verb=get,list --resource=pods"
      ;;
    create-rolebinding.sh)
      CMD="$script "$RESOURCE_NAME" "$NAMESPACE" --role=read-pods --user=dev"
      ;;
    create-clusterrole.sh)
      CMD="$script "$RESOURCE_NAME" --verb=get,list --resource=pods"
      ;;
    create-clusterrolebinding.sh)
      CMD="$script "$RESOURCE_NAME" --clusterrole=admin --user=admin-user"
      ;;
    create-secret.sh)
      CMD="$script "$RESOURCE_NAME" "$NAMESPACE" --from-literal=password=secret"
      ;;
    *)
      CMD="$script "$RESOURCE_NAME" "$NAMESPACE""
      ;;
  esac

  echo "▶️ Running: $CMD"
  eval $CMD

  echo "--------------------------"
done

echo
echo "✅ All create scripts executed."