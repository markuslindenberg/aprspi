#!/bin/sh

set -u
set -e

# Disable systemd-journald persistent storage
rmdir ${TARGET_DIR}/var/log/journal

# Enable resolved stub resolver
ln -sf ../run/systemd/resolve/stub-resolv.conf ${TARGET_DIR}/etc/resolv.conf

