#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.12.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.6

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/


#内核升级模块
#开始


wget -N https://raw.githubusercontent.com/openwrt/openwrt/191bcaffd1ffb1d28bb0102ec92e1ba455b2b11b/package/firmware/linux-firmware/Makefile -P package/firmware/linux-firmware/

#wget -N https://raw.githubusercontent.com/openwrt/openwrt/6ca430841b4e0d1d70bdd3fcb1c3afe236a888e5/target/linux/x86/config-6.12 -P target/linux/x86/


rm -rf target/linux/generic/backport-6.12/780-27-v6.15-r8169-don-t-scan-PHY-addresses-0.patch
rm -rf target/linux/generic/backport-6.12/780-33-v6.15-r8169-disable-RTL8126-ZRX-DC-timeout.patch
rm -rf target/linux/generic/backport-6.12/780-09-v6.13-r8169-add-support-for-RTL8125D.patch

wget -N https://raw.githubusercontent.com/openwrt/openwrt/6d14c619869b5bd2b339b2fd5972fb3e8cc7f7f4/target/linux/generic/backport-6.12/780-09-v6.13-r8169-add-support-for-RTL8125D.patch -P target/linux/generic/backport-6.12/


wget -N https://raw.githubusercontent.com/openwrt/openwrt/6ca430841b4e0d1d70bdd3fcb1c3afe236a888e5/target/linux/x86/config-6.12 -P target/linux/x86/

#以下不能动
wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/main/target/linux/generic/kernel-6.12 -P include/

wget -N https://raw.githubusercontent.com/openwrt/openwrt/66d0c22ec6927f9bb5e6e2dbb76f3b04b669f840/package/kernel/mt76/patches/002-wifi-mt76-replace-strlcpy-with-strscpy.patch -P package/kernel/mt76/patches/

#结束

sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8101 kmod-r8125 kmod-r8126 kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile

mv -f tmp/r81* feeds/miaogongzi/

sed -i 's/256/1024/g' target/linux/x86/image/Makefile


