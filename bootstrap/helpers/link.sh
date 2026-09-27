#!/usr/bin/env bash

link_config() {
	local source="$1"
	local target="$2"

	if [ -L "$target" ]; then
		if [ "$(readlink -f "$target")" = "$source" ]; then
			echo "Already linked: $target"
			return
		fi

		mv "$target" "${target}.backup-$(date +%Y%m%d-%H%M%S)"
	elif [ -e "$target" ]; then
		mv "$target" "${target}.backup-$(date +%Y%m%d-%H%M%S)"
	fi

	mkdir -p "$(dirname "$target")"
	ln -s "$source" "$target"

	echo "Linked: $target"
}
