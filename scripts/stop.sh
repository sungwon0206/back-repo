#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/home/ubuntu/aivle-backend"
PID_FILE="$APP_DIR/app.pid"

if [ -f "$PID_FILE" ]; then
  PID=$(cat "$PID_FILE" || true)
  if [ -n "${PID:-}" ] && kill -0 "$PID" 2>/dev/null; then
    echo "Stopping app (pid=$PID)..."
    kill "$PID" || true
    sleep 3
  fi
  rm -f "$PID_FILE"
fi

# 안전장치(꼬였을 때)
pkill -f "$APP_DIR/app.jar" || true
