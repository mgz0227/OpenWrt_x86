#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.18.sh

#git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.6

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/


#内核升级模块
#开始

rm -rf target/linux/generic/backport-6.12/510-v6.18-ksmbd-fix-recursive-locking-in-RPC-handle-list-access.patch
#以下不能动
wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/6.18.y/target/linux/generic/kernel-6.18 -P include/
wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/6.18.y/target/linux/generic/kernel-6.18 -P target/linux/generic/
#结束

#sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile


sed -i 's/256/1024/g' target/linux/x86/image/Makefile
