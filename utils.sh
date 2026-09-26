#!/bin/bash

confirm_delete() {
	local path="$1"
	[[ -e "$path" || -L "$path" ]] || return 0

	printf 'Found existing path: %s\n' "$path" >&2
	if [[ ! -t 0 ]]; then
		echo "Refusing to delete without interactive confirmation." >&2
		return 1
	fi

	local answer
	read -r -p "Delete this path and continue? [y/N] " answer
	case "$answer" in
		y|Y|yes|YES)
			echo "Deleting $path"
			rm -rf -- "$path"
			;;
		*)
			echo "Keeping $path; setup cancelled." >&2
			return 1
			;;
	esac
}
