#!/usr/bin/env bash

set -euo pipefail

if command -v oh-my-posh >/dev/null 2>&1; then
    echo "Oh My Posh already installed"
    exit 0
fi

curl -s https://ohmyposh.dev/install.sh | bash -s
