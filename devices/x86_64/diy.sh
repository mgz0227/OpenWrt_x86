#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.12.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.6

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/


#内核升级模块
#开始

#rm -rf target/linux/generic/hack-6.6/767-net-phy-realtek-add-led-link-select-for-RTL8221.patch
rm -rf target/linux/generic/pending-6.6/155-usbnet-restore-usb%d-name-exception-for-local-mac-addresses.patch
rm -rf target/linux/generic/hack-6.6/781-usb-net-rndis-support-asr.patch
rm -rf target/linux/generic/pending-6.6/620-net_sched-codel-do-not-defer-queue-length-update.patch
rm -rf target/linux/generic/pending-6.6/734-net-ethernet-mediatek-enlarge-DMA-reserve-buffer.patch
rm -rf target/linux/generic/hack-6.6/610-net-page_pool-try-to-free-deferred-skbs-while-waitin.patch

#wget -N https://github.com/openwrt/openwrt/blob/113d0268b4856d640cb380a71792b8fdc3b87802/config/Config-kernel.in -P /config

wget -N https://raw.githubusercontent.com/openwrt/openwrt/16dcde04aa0a4d292b27a4f0485223b9b03cae7d/package/kernel/linux/modules/fs.mk -P package/kernel/linux/modules/

wget -N https://raw.githubusercontent.com/openwrt/openwrt/16dcde04aa0a4d292b27a4f0485223b9b03cae7d/package/kernel/linux/modules/iio.mk -P package/kernel/linux/modules/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/16dcde04aa0a4d292b27a4f0485223b9b03cae7d/package/kernel/linux/modules/other.mk -P package/kernel/linux/modules/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/16dcde04aa0a4d292b27a4f0485223b9b03cae7d/package/kernel/linux/modules/video.mk -P package/kernel/linux/modules/

#wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/openwrt-24.10/package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc -P package/network/config/wifi-scripts/files/lib/wifi/

wget -N https://raw.githubusercontent.com/openwrt/openwrt/03cbc353d7e2f02a9ffa8f39dad67c8c2469426a/target/linux/generic/hack-6.6/610-net-page_pool-try-to-free-deferred-skbs-while-waitin.patch -P include/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/03cbc353d7e2f02a9ffa8f39dad67c8c2469426a/target/linux/generic/pending-6.6/620-net_sched-codel-do-not-defer-queue-length-update.patch -P include/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/03cbc353d7e2f02a9ffa8f39dad67c8c2469426a/target/linux/generic/pending-6.6/734-net-ethernet-mediatek-enlarge-DMA-reserve-buffer.patch -P include/
wget -N https://raw.githubusercontent.com/mgz0227/openwrt/main/target/linux/generic/kernel-6.6 -P include/

wget -N https://raw.githubusercontent.com/namiltd/openwrt/refs/heads/update/target/linux/generic/kernel-6.12 -P include/

wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/openwrt-24.10/include/kernel-version.mk -P include/

#结束

sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid amd64-microcode intel-microcode usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8101 kmod-r8125 kmod-r8126 kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile

mv -f tmp/r81* feeds/miaogongzi/

sed -i 's/256/1024/g' target/linux/x86/image/Makefile


