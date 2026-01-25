#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "THIS SCRIPT WILL INSTALL THE WM AND ITS DEPENDENCIES, THIS INCLUDES COPYING FILES TO YOUR HOME DIRECTORY"
read -rp "DO YOU WISH TO CONTINUE? (y/n) " response
if [[ ! "${response}" =~ ^[Yy]$ ]]; then
    echo "Installation aborted."
    exit 1
fi

echo "Starting installation..."
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing required packages..."
sudo apt install -y git i3 polybar feh fonts-jetbrains-mono fonts-font-awesome build-essential libgtk-3-dev libgtk-layer-shell-dev pamixer xdotool jq meson ninja-build
echo "Packages installed."

echo "Installing picom from source..."
tmpdir=$(mktemp -d)
trap 'rm -rf "${tmpdir}"' EXIT
sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev
git clone https://github.com/yshui/picom "${tmpdir}/picom"
cd "${tmpdir}/picom"
meson setup --buildtype=release build
ninja -C build
sudo cp build/src/picom /usr/local/bin
cd "${REPO_ROOT}"
echo "picom installed. Setting up configuration directories..."

mkdir -p "$HOME/.config/i3" "$HOME/.config/picom" "$HOME/.config/polybar"
cp -f "${REPO_ROOT}/i3/config" "$HOME/.config/i3/config"
cp -f "${REPO_ROOT}/i3/exec.conf" "$HOME/.config/i3/exec.conf"
cp -f "${REPO_ROOT}/i3/keybinds.conf" "$HOME/.config/i3/keybinds.conf"
cp -f "${REPO_ROOT}/i3/window_control.conf" "$HOME/.config/i3/window_control.conf"
cp -f "${REPO_ROOT}/picom/picom.conf" "$HOME/.config/picom/picom.conf"
cp -f "${REPO_ROOT}/polybar/config.ini" "$HOME/.config/polybar/config.ini"
cp -f "${REPO_ROOT}/polybar/launch.sh" "$HOME/.config/polybar/launch.sh"
chmod +x "$HOME/.config/polybar/launch.sh"
echo "Configuration files copied."

read -rp "Do you wish to install ulauncher as an application launcher? (y/n) " ulauncher_answer
if [[ "${ulauncher_answer}" =~ ^[Yy]$ ]]; then
    "${REPO_ROOT}/Scripts/ulauncher.sh"
fi

echo "Installation complete! Please restart your session to apply the changes."