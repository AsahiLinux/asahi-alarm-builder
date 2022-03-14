#!/bin/sh
set -e

mkdir -p /etc/systemd/system/systemd-firstboot.service.d/

cat >/etc/systemd/system/systemd-firstboot.service.d/no-prompt.conf <<EOF
[Service]
ExecStart=
ExecStart=systemd-firstboot
EOF
