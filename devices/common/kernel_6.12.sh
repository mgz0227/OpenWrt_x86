#!/bin/bash

shopt -s extglob

rm -rf target/linux package/kernel package/network/services/dnsmasq package/base-files package/boot package/firmware package/network package/libs
mkdir new; cp -rf .git new/.git
cd new
git reset --hard origin/master

cp -rf --parents target/linux package/kernel package/base-files package/boot package/firmware package/network package/libs config/Config-kernel.in ../
cd -

cd feeds/packages
rm -rf kernel/ovpn-dco libs/xr_usb_serial_common net/xtables-addons

cd ../../

cd package
rm -rf devel/kselftests-bpf devel/perf kernel/mt76 kernel/mt7621-qtn-rgmii

cd ../
