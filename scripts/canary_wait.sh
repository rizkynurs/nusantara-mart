#!/usr/bin/env bash
set -euo pipefail
NS="${1:-retail}"; RO="${2:-order}"; TARGET="${3:-50}"; TIMEOUT="${4:-10m}"
end=$((SECONDS+${TIMEOUT%m}*60))
while [ $SECONDS -lt $end ]; do
  W=$(kubectl argo rollouts get rollout "$RO" -n "$NS" -o jsonpath='{.status.canary.currentStepWeight}' 2>/dev/null || echo 0)
  echo "Current canary weight: ${W}%"
  if [ "${W:-0}" -ge "$TARGET" ]; then
    echo "Reached target ${TARGET}%"
    exit 0
  fi
  sleep 10
done
echo "Timeout waiting for ${TARGET}%"; exit 1
