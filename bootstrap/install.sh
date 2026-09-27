#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

echo "Installing dotfiles from: $REPO_ROOT"

for component in "$REPO_ROOT"/components/*/; do
    setup="$component/setup.sh"

    if [ -x "$setup" ]; then
        echo "Installing: $(basename "$component")"
        "$setup"
    fi
done
