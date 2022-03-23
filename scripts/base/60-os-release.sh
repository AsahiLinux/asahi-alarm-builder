#!/bin/sh
set -e

cat >/etc/os-release <<EOF
NAME="Asahi Linux"
PRETTY_NAME="Asahi Linux"
ID=asahi
ID_LIKE=arch
BUILD_ID=rolling
HOME_URL="https://asahilinux.org"
DOCUMENTATION_URL="https://github.com/asahilinux/docs/wiki"
BUG_REPORT_URL="https://github.com/AsahiLinux"
EOF
