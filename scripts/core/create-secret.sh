#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-secret.sh <name> [namespace]

# Vérifier les arguments
if [ -z "$1" ]; then
  echo "Usage: ./create-secret.sh <name> [namespace]"
  exit 1
fi

NAME="$1"
NS="${2:-default}"

echo "🔑 Choose how you want to create the secret:"
echo "   1) From literal key-value pairs"
echo "   2) From files"
echo "   3) From an env file"
echo -n "Select an option (1-3): "
read option

case "$option" in
  1)
    echo "You chose to create the secret from literal key-value pairs."
    secret_entries=()
    while true; do
      echo -n "Enter key (or press Enter to stop): "
      read key
      if [ -z "$key" ]; then
        break
      fi
      echo -n "Enter the value for '$key': "
      read value
      secret_entries+=("--from-literal=$key=$value")
    done
    if [ ${#secret_entries[@]} -gt 0 ]; then
      kubectl create secret generic "$NAME" "${secret_entries[@]}" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
    else
      echo "No valid key-value pairs provided."
      exit 1
    fi
    ;;
  2)
    echo "You chose to create the secret from files."
    echo -n "Enter the file path: "
    read file_path
    if [ -f "$file_path" ]; then
      kubectl create secret generic "$NAME" --from-file="$file_path" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
    else
      echo "File does not exist."
      exit 1
    fi
    ;;
  3)
    echo "You chose to create the secret from an env file."
    echo -n "Enter the env file path: "
    read env_file
    if [ -f "$env_file" ]; then
      kubectl create secret generic "$NAME" --from-env-file="$env_file" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
    else
      echo "File does not exist."
      exit 1
    fi
    ;;
  *)
    echo "Invalid option. Exiting."
    exit 1
    ;;
esac
