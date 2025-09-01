#!/bin/bash

shopt -s extglob

rm -rf target/linux package/boot package/devel package/firmware package/kernel package/libs package/network tools toolchain
mkdir new; cp -rf .git new/.git
cd new
git reset --hard origin/master

cp -rf --parents target/linux package/boot package/devel package/firmware package/kernel package/libs package/network tools toolchain config ../
cd -

cd feeds/packages
rm -rf net/xtables-addons net/strongswan utils/coremark lang/golang
git_clone_path master https://github.com/openwrt/packages net/xtables-addons net/strongswan lang/golang
cd ../../


cd package
rm -rf devel/kselftests-bpf 
#devel/perf
cd ../
