#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

host="${1:-0.0.0.0}"
port="${2:-4173}"
lan_ip="$(hostname -I 2>/dev/null | awk '{print $1}')"
local_name="$(hostname 2>/dev/null).local"

echo "Wonder World Coach"
echo "Serving on http://${host}:${port}/"
if [ -n "${lan_ip}" ]; then
  echo "LAN example: http://${lan_ip}:${port}/"
fi
echo "mDNS example: http://${local_name}:${port}/"

exec python3 -m http.server "$port" --bind "$host"
