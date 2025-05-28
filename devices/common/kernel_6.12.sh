#!/bin/bash

shopt -s extglob

rm -rf target/linux package/kernel package/network package/boot package/firmware package/network package/libs
mkdir new; cp -rf .git new/.git
cd new
git reset --hard origin/master

cp -rf --parents target/linux package/kernel  package/network package/boot package/firmware package/network package/libs config/Config-kernel.in ../
cd -

#cd feeds/packages
#rm -rf net/xtables-addons

#cd ../../
mv feeds/miaogongzi/xtables-addons feeds/packages/net/
cd package
rm -rf devel/kselftests-bpf devel/perf kernel/mt76

cd ../
