#!/usr/bin/env bash

set -euo pipefail

DOTFILES_BASHRC="$HOME/.dotfiles/components/bash/.bashrc"
USER_BASHRC="$HOME/.bashrc"

if [ ! -f "$DOTFILES_BASHRC" ]; then
    echo "Dotfiles Bash configuration not found: $DOTFILES_BASHRC"
    exit 1
fi

if [ ! -f "$USER_BASHRC" ]; then
    touch "$USER_BASHRC"
fi

OLD_SOURCE_LINE="source \"$HOME/.dotfiles/Components/bash/.bashrc\""
SOURCE_LINE="source \"$DOTFILES_BASHRC\""

if grep -Fq "$OLD_SOURCE_LINE" "$USER_BASHRC"; then
    sed -i '/# Load dotfiles Bash configuration/,+3d' "$USER_BASHRC"
fi

if grep -Fq "$SOURCE_LINE" "$USER_BASHRC"; then
    echo "Dotfiles Bash configuration already loaded"
    exit 0
fi

{
    echo ""
    echo "# Load dotfiles Bash configuration"
    echo "$SOURCE_LINE"
} >> "$USER_BASHRC"

echo "Added dotfiles Bash configuration to $USER_BASHRC"
