#!/bin/sh
set -e

mkdir -p /etc/NetworkManager/conf.d/
cp /files/nm/wifi_backend.conf /etc/NetworkManager/conf.d/

systemctl enable NetworkManager.service
systemctl enable iwd.service
