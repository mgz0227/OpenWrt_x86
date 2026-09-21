#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.18.sh

#git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.6

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/

#apk提示模块输出
rm -rf package/base-files/files/etc/profile.d/apk-cheatsheet.sh
#内核升级模块
#开始
#6.48.53
rm -rf target/linux/generic/backport-6.18/706-v7.2-bus-mhi-host-pci_generic-round-up-nr_irqs-to-a-power-of-two.patch
rm -rf target/linux/generic/backport-6.18/751-v7.2-net-dsa-qca8k-add-support-for-force-mode-for-fixed-l.patch
rm -rf target/linux/generic/backport-6.18/852-v7.1-rtc-cmos-use-platform_get_irq_optional.patch
rm -rf target/linux/generic/backport-6.18/942-04-v7.2-net-dsa-realtek-rtl8365mb-prepare-for-multiple-sourc.patch
rm -rf target/linux/generic/backport-6.18/942-05-v7.2-net-dsa-realtek-rtl8365mb-add-table-lookup-interface.patch
rm -rf target/linux/generic/backport-6.18/942-06-v7.2-net-dsa-realtek-rtl8365mb-add-VLAN-support.patch
rm -rf target/linux/generic/backport-6.18/942-07-v7.2-net-dsa-realtek-rtl8365mb-add-FDB-support.patch
rm -rf target/linux/generic/backport-6.18/942-08-v7.2-net-dsa-realtek-rtl8365mb-add-port_bridge_-join-leav.patch
rm -rf target/linux/generic/backport-6.18/942-09-v7.2-net-dsa-realtek-rtl8365mb-add-bridge-port-flags.patch
rm -rf target/linux/generic/backport-6.18/943-01-v7.3-net-dsa-realtek-rtl8365mb-add-SGMII-support.patch
rm -rf target/linux/generic/backport-6.18/943-02-v7.3-net-dsa-realtek-rtl8365mb-add-HSGMII-support.patch
rm -rf target/linux/generic/backport-6.18/944-01-v7.2-net-dsa-realtek-rtl8365mb-use-devm_mutex_init-for-mib_lock.patch
rm -rf target/linux/generic/backport-6.18/944-02-v7.2-net-dsa-realtek-use-devm_mutex_init-for-regmap-lock.patch
rm -rf target/linux/generic/backport-6.18/944-03-v7.2-net-dsa-realtek-use-devm_mutex_init-for-vlan_lock.patch
rm -rf target/linux/generic/backport-6.18/944-04-v7.2-net-dsa-realtek-use-devm_mutex_init-for-l2_lock.patch
rm -rf target/linux/generic/backport-6.18/946-v7.3-net-dsa-mt7530-populate-lpi_interfaces-to-fix-EEE-support.patch
rm -rf target/linux/generic/backport-6.18/947-v7.3-net-ethernet-mtk_eth_soc-populate-lpi_interfaces-to-fix-EEE-support.patch
rm -rf target/linux/generic/hack-6.18/890-serial-8250-add-UPIO_AU-case-to-set_io_from_upio.patch
rm -rf target/linux/generic/pending-6.18/737-10-net-ethernet-mtk_eth_soc-add-paths-and-SerDes-modes-.patch
rm -rf target/linux/generic/pending-6.18/738-01-net-ethernet-mtk_eth_soc-reduce-rx-ring-size-for-older.patch
#target/linux/generic
#git_clone_path 18 https://github.com/graysky2/openwrt target/linux/generic target/linux/generic


#以下不能动

wget -N https://raw.githubusercontent.com/mgz0227/openwrt/refs/heads/6.18.y/target/linux/generic/kernel-6.18 -P target/linux/generic/

#结束

#sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile


sed -i 's/256/1024/g' target/linux/x86/image/Makefile
