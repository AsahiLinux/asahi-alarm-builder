#!/bin.sh
set -e

sed -i -e 's/^#ParallelDownloads = 5/ParallelDownloads = 3/' /etc/pacman.conf
