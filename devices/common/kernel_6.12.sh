#!/bin/bash

shopt -s extglob

rm -rf target/linux package/boot package/devel package/firmware package/kernel package/libs package/network package/system package/utils tools toolchain
mkdir new; cp -rf .git new/.git
cd new
git reset --hard origin/master

cp -rf --parents target/linux package/boot package/devel package/firmware package/kernel package/libs package/network package/system package/utils tools toolchain config ../
cd -

cd feeds/packages
rm -rf net/xtables-addons net/strongswan net/cgi-io utils/coremark lang/golang utils/open-vm-tools libs/rpcsvc-proto libs
git_clone_path master https://github.com/openwrt/packages net/xtables-addons net/strongswan net/cgi-io lang/golang utils/open-vm-tools libs/rpcsvc-proto libs
cd ../../

#wget -N https://raw.githubusercontent.com/mgz0227/lucihttp/refs/heads/master/CMakeLists.txt feeds/luci/contrib/package/lucihttp
#cd package
#rm -rf devel/kselftests-bpf 
#devel/perf
#cd ../
