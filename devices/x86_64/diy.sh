#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.12.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.6

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/


#内核升级模块
#开始

#rm -rf target/linux/generic/hack-6.6/767-net-phy-realtek-add-led-link-select-for-RTL8221.patch

#wget -N https://raw.githubusercontent.com/openwrt/openwrt/16dcde04aa0a4d292b27a4f0485223b9b03cae7d/package/kernel/linux/modules/fs.mk -P package/kernel/linux/modules/


wget -N https://raw.githubusercontent.com/openwrt/openwrt/191bcaffd1ffb1d28bb0102ec92e1ba455b2b11b/package/firmware/linux-firmware/Makefile -P package/firmware/linux-firmware/



rm -rf target/linux/generic/pending-6.12/691-net-ipv6-fix-UDPv6-GSO-segmentation-with-NAT.patch

wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/main/target/linux/generic/kernel-6.12 -P include/

wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/openwrt-24.10/include/kernel-version.mk -P include/

#结束

sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8101 kmod-r8125 kmod-r8126 kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile

mv -f tmp/r81* feeds/miaogongzi/

sed -i 's/256/1024/g' target/linux/x86/image/Makefile


