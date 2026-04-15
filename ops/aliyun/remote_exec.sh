#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/server.env"

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "Missing ${ENV_FILE}. Copy server.env.example to server.env first." >&2
  exit 1
fi

# shellcheck source=/dev/null
source "${ENV_FILE}"

HOST="${ALIYUN_HOST:-aliyun}"

if [[ $# -eq 0 ]]; then
  echo "Usage: $0 \"remote command\"" >&2
  exit 1
fi

ssh "${HOST}" "$*"
