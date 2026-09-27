#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

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

echo "Installing dotfiles from: $REPO_ROOT"

link_config "$REPO_ROOT/components/nvim" "$HOME/.config/nvim"
