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
REMOTE_DIR="${REMOTE_APP_DIR:-/opt/weread-bot}"
VENV="${PYTHON_VENV:-venv}"
CRON_EXPR="${1:-*/5 * * * *}"

CRON_LINE="${CRON_EXPR} cd ${REMOTE_DIR} && ${REMOTE_DIR}/${VENV}/bin/python weread-bot.py --config config.yaml >> ${REMOTE_DIR}/logs/cron.log 2>&1"

ssh "${HOST}" "mkdir -p '${REMOTE_DIR}/logs'"
ssh "${HOST}" "(crontab -l 2>/dev/null | grep -v 'weread-bot.py --config config.yaml' ; echo '${CRON_LINE}') | crontab -"
ssh "${HOST}" "crontab -l"
