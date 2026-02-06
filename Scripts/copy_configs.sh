#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Copying config files (i3, picom, polybar) to ~/.config ..."

mkdir -p "$HOME/.config/i3" "$HOME/.config/picom" "$HOME/.config/polybar"

cp -rf "${REPO_ROOT}/i3/config" "$HOME/.config/i3/config"
cp -rf "${REPO_ROOT}/i3/exec.conf" "$HOME/.config/i3/exec.conf"
cp -rf "${REPO_ROOT}/i3/keybinds.conf" "$HOME/.config/i3/keybinds.conf"
cp -rf "${REPO_ROOT}/i3/window_control.conf" "$HOME/.config/i3/window_control.conf"

cp -rf "${REPO_ROOT}/picom/picom.conf" "$HOME/.config/picom/picom.conf"

cp -rf "${REPO_ROOT}/polybar/config.ini" "$HOME/.config/polybar/config.ini"
cp -rf "${REPO_ROOT}/polybar/launch.sh" "$HOME/.config/polybar/launch.sh"
chmod +x "$HOME/.config/polybar/launch.sh"

echo "Done. Restart i3 or run 'i3-msg reload' to apply."
