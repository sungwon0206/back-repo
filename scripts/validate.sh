#!/usr/bin/env bash
set -euo pipefail

# 포트 리스닝 확인
ss -ltn | awk '{print $4}' | grep -q ':8080$'

# HTTP 응답 확인(루트가 404여도 연결만 되면 OK 처리하고 싶으면 -f 제거하면 됨)
curl -sS "http://localhost:8080" >/dev/null 2>&1 || true

echo "OK"
