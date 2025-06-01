#!/bin/bash

shopt -s extglob

rm -rf target/linux package/boot package/firmware package/kernel package/libs package/network
mkdir new; cp -rf .git new/.git
cd new
git reset --hard origin/master

cp -rf --parents target/linux package/boot package/firmware package/kernel package/libs package/network config/Config-kernel.in ../
cd -

cd feeds/packages
rm -rf net/xtables-addons net/adblock
git_clone_path master https://github.com/openwrt/packages net/xtables-addons net/adblock
cd ../../

cd feeds/luci
rm -rf applications/luci-app-adblock
git_clone_path master https://github.com/openwrt/luci applications/luci-app-adblock
cd ../../


cd package
rm -rf devel/kselftests-bpf devel/perf 

cd ../
