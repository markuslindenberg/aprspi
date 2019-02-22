#!/bin/sh

set -u
set -e

# Ensure /boot mountpoint exists
mkdir -p ${TARGET_DIR}/boot

# Disable systemd-journald persistent storage
mkdir -p ${TARGET_DIR}/etc/systemd/journald.conf.d
echo "[Journal]\nStorage=volatile" > ${TARGET_DIR}/etc/systemd/journald.conf.d/volatile.conf

# Enable resolved stub resolver
ln -sf ../run/systemd/resolve/stub-resolv.conf ${TARGET_DIR}/etc/resolv.conf

