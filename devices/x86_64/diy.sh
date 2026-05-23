#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.18.sh

#git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.6

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/

#apk提示模块输出
rm -rf package/base-files/files/etc/profile.d/apk-cheatsheet.sh
#内核升级模块
#开始
rm -rf target/linux/generic/pending-6.18/151-net-bridge-do-not-send-arp-replies-if-src-and-target.patch

rm -rf target/linux/generic/backport-6.18/742-v7.1-r8152-fix-incorrect-register-write-to-USB_UPHY_XTAL.patch
rm -rf target/linux/generic/backport-6.18/827-v7.0-crypto-inside-secure-eip93-fix-register-definition.patch
rm -rf target/linux/generic/backport-6.18/828-v7.0-crypto-inside-secure-eip93-register-hash-before-auth.patch
rm -rf target/linux/generic/backport-6.18/940-v7.1-net-dsa-realtek-rtl8365mb-fix-mode-mask-calculation.patch
rm -rf target/linux/generic/pending-6.18/928-crypto-eip93-fix-hmac-setkey-algo-selection.patch
#wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/6.18.y/target/linux/generic/pending-6.18/360-Revert-MIPS-mm-kmalloc-tlb_vpn-array-to-avoid-stack-.patch -P target/linux/generic/pending-6.18/
#以下不能动

wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/6.18.y/target/linux/generic/kernel-6.18 -P target/linux/generic/

#结束

#sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile


sed -i 's/256/1024/g' target/linux/x86/image/Makefile
