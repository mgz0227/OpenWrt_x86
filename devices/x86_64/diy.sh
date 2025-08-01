#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.12.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.6

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/


#内核升级模块
#开始
#rm -rf target/linux/generic/backport-6.12/780-09-v6.13-r8169-add-support-for-RTL8125D.patch
#rm -rf target/linux/generic/backport-6.12/781-04-v6.13-net-phy-realtek-merge-the-drivers-for-internal-NBase.patch
#rm -rf target/linux/generic/backport-6.12/781-05-v6.13-net-phy-realtek-add-RTL8125D-internal-PHY.patch
#rm -rf target/linux/generic/pending-6.12/680-net-fix-TCP-UDP-fraglist-GRO.patch
#Wget -N https://github.com/mgz0227/packages/raw/refs/heads/Rust/lang/rust/patches/002-bypass-github-actions-ci.patch -P feeds/lang/rust/patches/
#以下不能动
#wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/main/target/linux/generic/kernel-6.12 -P include/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/2be61fbc344d7b00039ae5800b3419b6ac79075f/target/linux/generic/kernel-6.12 -P include/

#结束

sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8101 kmod-r8125 kmod-r8126 kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile

mv -f tmp/r81* feeds/miaogongzi/

sed -i 's/256/1024/g' target/linux/x86/image/Makefile
