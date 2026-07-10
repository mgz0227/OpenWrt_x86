#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
bash "$SCRIPT_DIR/../common/kernel_6.18.sh"

rm -f package/base-files/files/etc/profile.d/apk-cheatsheet.sh

default_packages="kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf"
grep -q '^DEFAULT_PACKAGES +=' target/linux/x86/Makefile
sed -i "0,/^DEFAULT_PACKAGES +=/s||& $default_packages|" target/linux/x86/Makefile

grep -qE '^[[:space:]]*256[[:space:]]*$' target/linux/x86/image/Makefile
sed -i '/^[[:space:]]*256[[:space:]]*$/s/256/1024/' target/linux/x86/image/Makefile
