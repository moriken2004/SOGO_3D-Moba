#!/bin/sh
# One-shot launcher for Sogo 3D / 立体4目並べ.
#
# Run from this folder:   ./run.sh   (or: sh run.sh)
#
#   1. Frees the port by killing any prior local server on it.
#   2. Starts python3's HTTP server in the background.
#   3. Opens the game in Safari (macOS) / xdg-open's default (Linux).
#
# Stop:  re-run this script (it kills the prior server before starting a new one),
#        or:  kill $(lsof -ti :8000)
#
# 使い方：このフォルダで ./run.sh
#   1. 既存サーバを停止 → 2. 新サーバ起動 → 3. Safari / 既定ブラウザで自動起動
set -eu

PORT=8000
DIR="$(cd "$(dirname "$0")" && pwd)"
URL="http://127.0.0.1:${PORT}/sogo3d.html"

# 1) Kill any previous local server on the port (lsof -ti prints PIDs only).
existing="$(lsof -ti :${PORT} 2>/dev/null || true)"
if [ -n "${existing}" ]; then
  printf 'stopping previous server on port %s (pid %s)\n' "${PORT}" "${existing}"
  kill ${existing} 2>/dev/null || true
  # Give the kernel a beat to release the socket.
  sleep 0.3
fi

# 2) Start the server in the background, detached, with output silenced.
cd "${DIR}"
nohup python3 -m http.server "${PORT}" --bind 127.0.0.1 >/dev/null 2>&1 &
PID=$!
printf 'serving %s on port %s (pid %s)\n' "${DIR}" "${PORT}" "${PID}"

# 3) Wait briefly for the socket to bind, then open the page.
sleep 0.4
case "$(uname -s)" in
  Darwin) open -a Safari "${URL}" ;;
  Linux)  xdg-open "${URL}" >/dev/null 2>&1 || sensible-browser "${URL}" || true ;;
  *)      printf 'open this URL in your browser: %s\n' "${URL}" ;;
esac
printf 'open: %s\n' "${URL}"
