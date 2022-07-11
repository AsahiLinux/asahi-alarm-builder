#!/bin/sh
set -e

mkdir -p "/boot/efi"

pacman --noconfirm -R linux-aarch64
pacman --noconfirm -Syu
pacman --noconfirm -S asahi-scripts asahi-fwextract m1n1 uboot-asahi mkinitcpio grub iwd
