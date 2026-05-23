#!/bin/bash

shopt -s extglob

rm -rf target/linux package/boot package/devel package/firmware package/kernel package/libs package/network tools toolchain
mkdir new; cp -rf .git new/.git
cd new
git reset --hard origin/main

cp -rf --parents target/linux package/boot package/devel package/firmware package/kernel package/libs package/network tools toolchain config ../

cd -


cd feeds/packages
rm -rf net/xtables-addons net/jool kernel/v4l2loopback kernel/ovpn-dco libs/libpfring libs/libmariadb

git_clone_path master https://github.com/openwrt/packages net/jool kernel/v4l2loopback libs/libpfring net/xtables-addons libs/libmariadb kernel/ovpn-dco

cd ../../

cd package
rm -rf devel/kselftests-bpf  kernel/mt76 kernel/ath10k-ct 

cd ../

rm -rf package/kernel/ath10k-ct package/kernel/mt76 
