#!/bin/sh

set -u
set -e

# Disable systemd-journald persistent storage
mkdir -p ${TARGET_DIR}/etc/systemd/journald.conf.d
echo "[Journal]\nStorage=volatile" > ${TARGET_DIR}/etc/systemd/journald.conf.d/volatile.conf
if [ -e ${TARGET_DIR}/var/log/journal ]; then
  rmdir ${TARGET_DIR}/var/log/journal
fi

# Enable resolved stub resolver
ln -sf ../run/systemd/resolve/stub-resolv.conf ${TARGET_DIR}/etc/resolv.conf

if ! grep -qE ' /boot' "${TARGET_DIR}/etc/fstab"; then
	echo "/dev/mmcblk0p1 /boot vfat rw,noatime,fmask=0177,dmask=0077,flush,discard 0 0" >> ${TARGET_DIR}/etc/fstab
fi

# Set SSH host key location to /boot
if ! grep -qE '^HostKey' "${TARGET_DIR}/etc/ssh/sshd_config"; then
	echo "HostKey /boot/ssh_host_rsa_key" >> ${TARGET_DIR}/etc/ssh/sshd_config
	echo "HostKey /boot/ssh_host_ecdsa_key" >> ${TARGET_DIR}/etc/ssh/sshd_config
	echo "HostKey /boot/ssh_host_ed25519_key" >> ${TARGET_DIR}/etc/ssh/sshd_config
fi

