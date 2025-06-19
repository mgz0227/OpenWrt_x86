#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.12.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.6

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/


#内核升级模块
#开始

rm -rf target/linux/generic/backport-6.12/610-06-v6.16-net-dsa-b53-do-not-enable-RGMII-delay-on-bcm63xx.patch
rm -rf target/linux/generic/backport-6.12/421-02-v6.16-spi-bcm63xx-hsspi-fix-shared-reset.patch
rm -rf target/linux/generic/backport-6.12/421-01-v6.16-spi-bcm63xx-spi-fix-shared-reset.patch
rm -rf target/linux/generic/backport-6.12/610-09-v6.16-net-dsa-b53-do-not-touch-DLL_IQQD-on-bcm53115.patch


wget -N https://raw.githubusercontent.com/openwrt/openwrt/66d0c22ec6927f9bb5e6e2dbb76f3b04b669f840/package/kernel/mt76/patches/002-wifi-mt76-replace-strlcpy-with-strscpy.patch -P package/kernel/mt76/patches/

#以下不能动
wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/main/target/linux/generic/kernel-6.12 -P include/

#结束

sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8101 kmod-r8125 kmod-r8126 kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile

mv -f tmp/r81* feeds/miaogongzi/

sed -i 's/256/1024/g' target/linux/x86/image/Makefile
