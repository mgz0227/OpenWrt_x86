#!/usr/bin/env bash

git_clone_path() {
	local ref="${1:?missing Git ref}"
	local repository="${2:?missing repository URL}"
	shift 2

	local mode="copy"
	if [[ "${1:-}" == "mv" ]]; then
		mode="move"
		shift
	fi
	(( $# > 0 )) || {
		echo "git_clone_path: at least one path is required" >&2
		return 2
	}

	local root_dir="$PWD"
	local temp_dir
	temp_dir="$(mktemp -d)"

	if [[ "$ref" =~ ^[0-9a-fA-F]{40}$ ]]; then
		git -C "$temp_dir" init --quiet
		git -C "$temp_dir" remote add origin "$repository"
		if ! git -C "$temp_dir" fetch --depth 1 origin "$ref"; then
			rm -rf "$temp_dir"
			return 1
		fi
		git -C "$temp_dir" sparse-checkout init --cone
		git -C "$temp_dir" sparse-checkout set -- "$@"
		if ! git -C "$temp_dir" checkout --detach FETCH_HEAD; then
			rm -rf "$temp_dir"
			return 1
		fi
	else
		if ! git clone --quiet --depth 1 --filter=blob:none --sparse --branch "$ref" "$repository" "$temp_dir"; then
			rm -rf "$temp_dir"
			return 1
		fi
		git -C "$temp_dir" sparse-checkout set -- "$@"
	fi
	# shellcheck disable=SC2034 # Returned to callers in the current shell.
	CLONED_GIT_COMMIT="$(git -C "$temp_dir" rev-parse HEAD)"

	local path source destination
	for path in "$@"; do
		source="$temp_dir/$path"
		destination="$root_dir/$path"
		[[ -e "$source" ]] || {
			echo "git_clone_path: path not found in $repository@$ref: $path" >&2
			rm -rf "$temp_dir"
			return 1
		}

		mkdir -p "$(dirname "$destination")"
		if [[ "$mode" == "move" ]]; then
			rm -rf "$destination"
			mv "$source" "$destination"
		elif [[ -d "$source" && -d "$destination" ]]; then
			cp -a "$source/." "$destination/"
		else
			rm -rf "$destination"
			cp -a "$source" "$destination"
		fi
	done

	rm -rf "$temp_dir"
}

sync_openwrt_paths() {
	local ref="${1:?missing OpenWrt ref}"
	shift
	(( $# > 0 )) || {
		echo "sync_openwrt_paths: at least one path is required" >&2
		return 2
	}

	git fetch --no-tags --depth 1 origin "$ref"
	SYNCED_OPENWRT_COMMIT="$(git rev-parse FETCH_HEAD)"

	local path
	for path in "$@"; do
		rm -rf "$path"
	done
	git restore --source="$SYNCED_OPENWRT_COMMIT" --worktree -- "$@"
}
