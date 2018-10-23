#!/bin/sh

set -u
set -e

# Disable systemd-journald persistent storage
rmdir ${TARGET_DIR}/var/log/journal

