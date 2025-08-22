#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.12.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.6

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/


#内核升级模块
#开始
wget -N http://cdn.miaogongzi.cc/patch/6.12.43-1.patch -P target/linux/x86/patches-6.12
rm -rf target/linux/generic/backport-6.12/612-11-v6.17-net-dsa-b53-prevent-GMII_PORT_OVERRIDE_CTRL-access-on-BCM5325.patch
rm -rf target/linux/generic/backport-6.12/612-09-v6.17-net-dsa-b53-prevent-DIS_LEARNING-access-on-BCM5325.patch
rm -rf target/linux/generic/backport-6.12/612-08-v6.17-net-dsa-b53-fix-IP_MULTICAST_CTRL-on-BCM5325.patch
rm -rf target/linux/generic/backport-6.12/612-07-v6.17-net-dsa-b53-prevent-SWITCH_CTRL-access-on-BCM5325.patch
rm -rf target/linux/generic/backport-6.12/612-14-v6.17-net-dsa-b53-ensure-BCM5325-PHYs-are-enabled.patch
rm -rf target/linux/generic/backport-6.12/830-v6.17-Revert-leds-trigger-netdev-Configure-LED-blink-inter.patch
#Wget -N https://github.com/mgz0227/packages/raw/refs/heads/Rust/lang/rust/patches/002-bypass-github-actions-ci.patch -P feeds/lang/rust/patches/

wget -N https://raw.githubusercontent.com/openwrt/openwrt/8284e38421ad3771f0f872b1d4ed1b86b6c2a567/target/linux/generic/config-6.12 -P target/linux/generic/
#以下不能动
wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/main/target/linux/generic/kernel-6.12 -P include/
wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/main/target/linux/generic/kernel-6.12 -P target/linux/generic/
#wget -N https://raw.githubusercontent.com/openwrt/openwrt/886c3d8b92223683706eafb7b904068fa2324993/target/linux/generic/kernel-6.12 -P include/


#结束

sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8101 kmod-r8125 kmod-r8126 kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile

mv -f tmp/r81* feeds/miaogongzi/

sed -i 's/256/1024/g' target/linux/x86/image/Makefile
