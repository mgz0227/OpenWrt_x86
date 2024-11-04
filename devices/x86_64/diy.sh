#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.6.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.6

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/64/config-6.6 -P target/linux/x86/64/

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/firmware/linux-firmware/intel.mk -P package/firmware/linux-firmware/

#wget -N https://raw.githubusercontent.com/mgz0227/openwrt/main/include/kernel-6.6 -P include/
#rm -rf package/network/utils/xdp-tools
#wget -N https://raw.githubusercontent.com/namiltd/package/kernel/mac80211/patches/build/236-fix-genlmsg_multicast_allns-build-error-on-kernel-6.6.59.patch -P package/kernel/mac80211/patches/build/
#rm -rf /target/linux/generic/backport-6.6/777-netfilter-xtables-fix-typo-causing-some-targets-to-not-load-on-IPv6.patch
#rm -rf target/linux/generic/backport-6.6/780-22-v6.12-r8169-add-support-for-RTL8126A-rev.b.patch
#rm -rf /target/linux/generic/backport-6.6/780-24-v6.12-r8169-avoid-unsolicited-interrupts.patch
#rm -rf target/linux/generic/pending-6.6/684-gso-fix-gso-fraglist-segmentation-after-pull-from-fr.patch
#wget -N https://raw.githubusercontent.com/mgz0227/openwrt/main/target/linux/generic/backport-6.6/819-v6.8-0005-nvmem-core-Rework-layouts-to-become-regular-devices.patch target/linux/generic/backport-6.6/

sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-usb-hid kmod-mmc kmod-sdhci usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8101 kmod-r8125 kmod-r8126 kmod-8139cp kmod-8139too kmod-i40e kmod-drm-i915 kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile
sed -i "s/192.168.1/192.168.3/" package/feeds/miaogongzi/base-files/files/bin/config_generate
mv -f tmp/r81* feeds/miaogongzi/

sed -i 's/256/1024/g' target/linux/x86/image/Makefile

echo '
CONFIG_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_NR_CPUS=512
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_SDIO_UART=y
CONFIG_MMC_TEST=y
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_DRM_I915=y
' >> ./target/linux/x86/config-6.6

sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

