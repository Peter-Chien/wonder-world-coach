#!/usr/bin/env bash
set -euo pipefail

app_name="wonder-world-coach"
port="${1:-4173}"
install_dir="${HOME}/apps/${app_name}"
service_dir="${HOME}/.config/systemd/user"
service_file="${service_dir}/${app_name}.service"
source_dir="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$install_dir" "$service_dir"

rsync -a --delete \
  --exclude ".git" \
  --exclude "*.tar.gz" \
  "${source_dir}/" "${install_dir}/"

chmod +x "${install_dir}/start-lan.sh"

cat > "$service_file" <<SERVICE
[Unit]
Description=Wonder World Coach learning app
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
WorkingDirectory=${install_dir}
ExecStart=${install_dir}/start-lan.sh 0.0.0.0 ${port}
Restart=on-failure
RestartSec=3

[Install]
WantedBy=default.target
SERVICE

systemctl --user daemon-reload
systemctl --user enable --now "${app_name}.service"

lan_ip="$(hostname -I 2>/dev/null | awk '{print $1}')"
local_name="$(hostname 2>/dev/null).local"

echo
echo "Installed ${app_name}."
echo "Service: systemctl --user status ${app_name}.service"
if [ -n "$lan_ip" ]; then
  echo "Tablet URL: http://${lan_ip}:${port}/"
fi
echo "Tablet URL: http://${local_name}:${port}/"
echo
echo "Optional: keep it running before login / after reboot:"
echo "  sudo loginctl enable-linger $(whoami)"
