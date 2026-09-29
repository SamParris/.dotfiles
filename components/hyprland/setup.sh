#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../.." && pwd)"

. "$REPO_ROOT/bootstrap/helpers/link.sh"

link_config "$REPO_ROOT/components/hyprland" "$HOME/.config/hypr"
