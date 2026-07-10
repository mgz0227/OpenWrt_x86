#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/functions.sh"

kernel_ref="${KERNEL_SOURCE_REF:-main}"
source_paths=(
	target/linux
	package/boot
	package/devel
	package/firmware
	package/kernel
	package/libs
	package/network
	tools
	toolchain
	config
)

echo "Synchronizing OpenWrt kernel tree from $kernel_ref"
sync_openwrt_paths "$kernel_ref" "${source_paths[@]}"
printf '%s\n' "$SYNCED_OPENWRT_COMMIT" > .kernel-source-commit

packages_ref="${KERNEL_PACKAGES_SOURCE_REF:-master}"
package_paths=(
	net/xtables-addons
	net/jool
	kernel/v4l2loopback
	kernel/ovpn-dco
	libs/libpfring
	libs/libmariadb
)

pushd feeds/packages >/dev/null
for path in "${package_paths[@]}"; do
	rm -rf "$path"
done
git_clone_path "$packages_ref" https://github.com/openwrt/packages.git "${package_paths[@]}"
printf '%s\n' "$CLONED_GIT_COMMIT" > "$OLDPWD/.kernel-packages-source-commit"
popd >/dev/null

rm -rf package/devel/kselftests-bpf package/kernel/ath10k-ct package/kernel/mt76
