#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/home/ubuntu/aivle-backend"
JAR="$APP_DIR/app.jar"
LOG="$APP_DIR/logs/app.log"
PID_FILE="$APP_DIR/app.pid"

mkdir -p "$APP_DIR/logs"

if [ ! -f "$JAR" ]; then
  echo "ERROR: $JAR not found"
  exit 1
fi

# 8080 포트 점유 확인
if ss -ltn | awk '{print $4}' | grep -q ':8080$'; then
  echo "ERROR: Port 8080 is already in use."
  exit 1
fi

echo "Starting app..."
nohup java -jar "$JAR" --server.port=8080 > "$LOG" 2>&1 &
echo $! > "$PID_FILE"
sleep 2
echo "Started. pid=$(cat "$PID_FILE")"
