#!/bin/bash
#=================================================
shopt -s extglob

#临时切换mirror
sed -i 's#https://git.openwrt.org/feed/packages.git#https://github.com/openwrt/packages.git#g' feeds.conf.default
sed -i 's#https://git.openwrt.org/project/luci.git#https://github.com/openwrt/luci.git#g' feeds.conf.default
sed -i 's#https://git.openwrt.org/feed/routing.git#https://github.com/openwrt/routing.git#g' feeds.conf.default
#


sed -i '$a src-git miaogongzi https://github.com/mgz0227/OP-Packages.git;master' feeds.conf.default
sed -i "/telephony/d" feeds.conf.default

sed -i "s?targets/%S/packages?targets/%S/\$(LINUX_VERSION)?" include/feeds.mk

sed -i '/	refresh_config();/d' scripts/feeds

./scripts/feeds update -a
./scripts/feeds install -a -p miaogongzi -f
./scripts/feeds install -a

sed --follow-symlinks -i "s#%C\"#%C by miaogongzi\"#" package/base-files/files/etc/os-release
sed -i -e '$a /etc/bench.log' \
        -e '/\/etc\/profile/d' \
        -e '/\/etc\/shinit/d' \
        package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i -e '/^\/etc\/profile/d' \
        -e '/^\/etc\/shinit/d' \
        package/base-files/Makefile
sed -i "s/192.168.1/192.168.3/" package/base-files/files/bin/config_generate

wget -N https://github.com/immortalwrt/immortalwrt/raw/refs/heads/openwrt-24.10/package/kernel/linux/modules/video.mk -P package/kernel/linux/modules/
wget -N https://github.com/immortalwrt/immortalwrt/raw/refs/heads/openwrt-24.10/package/network/utils/nftables/patches/002-nftables-add-fullcone-expression-support.patch -P package/network/utils/nftables/patches/
wget -N https://github.com/immortalwrt/immortalwrt/raw/refs/heads/openwrt-24.10/package/network/utils/nftables/patches/001-drop-useless-file.patch -P package/network/utils/nftables/patches/
wget -N https://github.com/immortalwrt/immortalwrt/raw/refs/heads/openwrt-24.10/package/libs/libnftnl/patches/001-libnftnl-add-fullcone-expression-support.patch -P package/libs/libnftnl/patches/
wget -N https://github.com/immortalwrt/immortalwrt/raw/refs/heads/openwrt-24.10/package/firmware/wireless-regdb/patches/600-custom-change-txpower-and-dfs.patch -P package/firmware/wireless-regdb/patches/
#wget -N https://github.com/immortalwrt/immortalwrt/raw/refs/heads/master/config/Config-kernel.in -P config/

rm -rf package/libs/openssl package/network/services/ppp
git_clone_path openwrt-24.10 https://github.com/immortalwrt/immortalwrt package/libs/openssl package/network/services/ppp

echo "$(date +"%s")" >version.date
sed -i '/$(curdir)\/compile:/c\$(curdir)/compile: package/opkg/host/compile' package/Makefile
sed -i "s/DEFAULT_PACKAGES:=/DEFAULT_PACKAGES:=luci-app-advancedplus luci-app-firewall luci-app-package-manager \
luci-app-wizard luci-base luci-compat luci-lib-ipkg luci-lib-fs luci-app-log-viewer \
luci-app-argon-config luci-app-ddns-go luci-app-openclash luci-app-adblock tcpdump-mini open-vm-tools \
coremark wget-ssl curl autocore htop nano zram-swap kmod-lib-zstd kmod-tcp-bbr bash openssh-sftp-server block-mount resolveip ds-lite swconfig luci-app-fan luci-app-filemanager /" include/target.mk

sed -i "s/procd-ujail//" include/target.mk

sed -i "s/^.*vermagic$/\techo '1' > \$(LINUX_DIR)\/.vermagic/" include/kernel-defaults.mk

status=$(curl -H "Authorization: token $REPO_TOKEN" -s "https://api.github.com/repos/mgz0227/OP-Packages/actions/runs" | jq -r '.workflow_runs[0].status')
echo "$status"
while [[ "$status" == "in_progress" || "$status" == "queued" ]];do
	echo "wait 5s"
	sleep 5
	status=$(curl -H "Authorization: token $REPO_TOKEN" -s "https://api.github.com/repos/mgz0227/OP-Packages/actions/runs" | jq -r '.workflow_runs[0].status')
done

mv -f feeds/miaogongzi/r81* tmp/

wget -N https://raw.githubusercontent.com/openwrt/packages/master/lang/golang/golang/Makefile -P feeds/packages/lang/golang/golang/

#sed -i "/call Build\/check-size,\$\$(KERNEL_SIZE)/d" include/image.mk

git_clone_path master https://github.com/coolsnowwolf/lede mv target/linux/generic/hack-6.6

rm -rf package/system/fstools
git_clone_path master https://github.com/coolsnowwolf/lede package/system/fstools

rm -rf target/linux/generic/hack-6.6/767-net-phy-realtek-add-led*
wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.6/613-netfilter_optional_tcp_window_check.patch -P target/linux/generic/pending-6.6/

# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
#rm -rf ./feeds/packages/lang/{golang,node}
sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab

date=`date +%m.%d.%Y`
sed -i -e "/\(# \)\?REVISION:=/c\REVISION:=$date" -e '/VERSION_CODE:=/c\VERSION_CODE:=$(REVISION)' include/version.mk

sed -i 's/option timeout 30/option timeout 60/g' package/system/rpcd/files/rpcd.config
sed -i 's#20) \* 1000#60) \* 1000#g' feeds/luci/modules/luci-base/htdocs/luci-static/resources/rpc.js

sed -i \
	-e "s/+\(luci\|luci-ssl\|uhttpd\)\( \|$\)/\2/" \
	-e "s/+nginx\( \|$\)/+nginx-ssl\1/" \
	-e 's/+python\( \|$\)/+python3/' \
	-e 's?../../lang?$(TOPDIR)/feeds/packages/lang?' \
	package/feeds/miaogongzi/*/Makefile

sed -i "s/OpenWrt/MeowWrt/g" package/base-files/files/bin/config_generate package/base-files/image-config.in package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc config/Config-images.in Config.in include/u-boot.mk  || true

sed -i -e "s/set \${s}.country='\${country || ''}'/set \${s}.country='\${country || \"CN\"}'/g" -e "s/set \${s}.disabled=.*/set \${s}.disabled='0'/" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

rm -rf package/feeds/packages/jool
