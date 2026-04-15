#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
ENV_FILE="${SCRIPT_DIR}/server.env"

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "Missing ${ENV_FILE}. Copy server.env.example to server.env first." >&2
  exit 1
fi

# shellcheck source=/dev/null
source "${ENV_FILE}"

HOST="${ALIYUN_HOST:-aliyun}"
REMOTE_DIR="${REMOTE_APP_DIR:-/opt/weread-bot}"

echo "[1/4] Ensure remote dir exists"
ssh "${HOST}" "mkdir -p '${REMOTE_DIR}'"

echo "[2/4] Sync project files (exclude local cache/git/venv)"
tar \
  --exclude='.git' \
  --exclude='.venv' \
  --exclude='venv' \
  --exclude='logs/*' \
  --exclude='__pycache__' \
  --exclude='*.pyc' \
  -C "${ROOT_DIR}" -cf - . | ssh "${HOST}" "tar -xf - -C '${REMOTE_DIR}'"

echo "[3/4] Ensure python venv and deps"
ssh "${HOST}" "cd '${REMOTE_DIR}' && if [[ ! -d '${PYTHON_VENV:-venv}' ]]; then python3 -m venv '${PYTHON_VENV:-venv}'; fi && source '${PYTHON_VENV:-venv}/bin/activate' && pip install -q --upgrade pip && pip install -q -r requirements.txt"

echo "[4/4] Done"
echo "Remote app dir: ${REMOTE_DIR}"
