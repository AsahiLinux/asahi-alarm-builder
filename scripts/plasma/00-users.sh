#!/bin/sh
set -e

# Calamares script does this after a successful run
#usermod -p '*' root

userdel -r alarm
