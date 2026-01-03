#!/bin/bash

shopt -s extglob

rm -rf target/linux package/boot package/devel package/firmware package/kernel package/libs package/network package/kernel tools toolchain
mkdir new; cp -rf .git new/.git
cd new
git reset --hard origin/6.18.y

cp -rf --parents target/linux package/boot package/devel package/firmware package/kernel package/libs package/network package/kernel tools toolchain config ../
rm -rf target/linux/bcm53xx
cd -


#nat46: fix reproducible-build failure and use latest git
wget -N https://github.com/graysky2/openwrt/commit/e52d04b65d1942f581533cb2054e74f4ff5bd70b.patch -P devices/common/patches/


cd feeds/packages
rm -rf libs/libpfring/patches/* libs/libmariadb
rm -rf libs/libpfring/Makefile
git_clone_path libmaria https://github.com/graysky2/packages libs/libmariadb

wget -N https://raw.githubusercontent.com/graysky2/packages/91f0b3e8621ae529d01356bfe411c91d25e22b4b/libs/libpfring/patches/0001-fix-cross-compiling.patch -P libs/libpfring/patches/
wget -N https://raw.githubusercontent.com/graysky2/packages/91f0b3e8621ae529d01356bfe411c91d25e22b4b/libs/libpfring/patches/010-gcc14.patch -P libs/libpfring/patches/
wget -N https://raw.githubusercontent.com/graysky2/packages/91f0b3e8621ae529d01356bfe411c91d25e22b4b/libs/libpfring/patches/100-fix-compilation-warning.patch -P libs/libpfring/patches/
wget -N https://raw.githubusercontent.com/graysky2/packages/91f0b3e8621ae529d01356bfe411c91d25e22b4b/libs/libpfring/patches/200-net-s-dev_get_flags-netif_get_flags.patch -P libs/libpfring/patches/
wget -N https://raw.githubusercontent.com/graysky2/packages/91f0b3e8621ae529d01356bfe411c91d25e22b4b/libs/libpfring/Makefile -P libs/libpfring/
cd ../../



cd feeds/packages
rm -rf net/xtables-addons net/jool kernel/v4l2loopback
#libs/libpfring
git_clone_path master https://github.com/openwrt/packages net/jool kernel/v4l2loopback
git_clone_path 6.18-xt-addons https://github.com/graysky2/packages net/xtables-addons
wget -N https://raw.githubusercontent.com/graysky2/packages/c55afaa2bebca50a0e019a249c2748e7d7f745b7/kernel/ovpn-dco/Makefile -P kernel/ovpn-dco/

cd ../../

#cd feeds/miaogongzi
#rm -rf fibocom_QMI_WWAN rkp-ipid
#cd ../../



cd package
rm -rf devel/kselftests-bpf  libs/libnl/Makefile 

#wget -N https://patch-diff.githubusercontent.com/raw/openwrt/mt76/pull/1026.patch -P kernel/mt76/patches/
#mv kernel/mt76/patches/1026.patch kernel/mt76/patches/002-fix-mt76-timer-compat.patch

wget -N https://raw.githubusercontent.com/graysky2/openwrt/061613c6ec0353d2ca70f8e15d47c1a6ed70f501/package/libs/libnl/Makefile -P libs/libnl/ 

cd ../

