#!/bin/bash
# Create a CronJob from user input
# Usage: ./create-cronjob.sh <name> [namespace]

set -e

[ -z "$1" ] && echo "Usage: $0 <name> [namespace]" && exit 1

NAME="$1"
NAMESPACE="${2:-default}"

read -p "⏰ Enter the cron schedule (e.g. '*/5 * * * *'): " SCHEDULE
read -p "🐳 Enter the container image (e.g. 'busybox'): " IMAGE
read -p "📥 Enter the command to run (default: 'echo Hello'): " CMD
CMD="${CMD:-echo Hello}"

cat <<EOF | kubectl apply -f -
apiVersion: batch/v1
kind: CronJob
metadata:
  name: $NAME
  namespace: $NAMESPACE
spec:
  schedule: "$SCHEDULE"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: $NAME
            image: $IMAGE
            command: ["/bin/sh", "-c", "$CMD"]
          restartPolicy: OnFailure
EOF

