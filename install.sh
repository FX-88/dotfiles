#!/usr/bin/env bash
# THIS IS GONNA BE A BETTER SCRIPT THAT INCLUDES ALL THE "SUB-SCRIPTS" LIKE graphic.sh AND OTHERS

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "THIS SCRIPT NEEDS TO BE TESTED BEFORE BEING USED IN PRODUCTION"
read -rp "ARE YOU TESTING THE SCRIPT? (y/n) " test_answer
if [[ ! "${test_answer}" =~ ^[Yy]$ ]]; then
    echo "Installation aborted."
    exit 1
fi

echo "Proceeding with installation..."
echo
echo "Choose what you want to install:"
echo "1. Complete installation (graphic environment [polybar + picom] + window manager [i3])"
echo "2. Complete installation (graphic environment [eww + picom] + window manager [i3])"
echo "3. Graphic environment [polybar + picom]"
echo "4. Just ULauncher"
echo "5. Exit"
read -rp "Selection: " choice

run_script() {
    local script_path="$1"
    chmod +x "${script_path}"
    "${script_path}"
}

case "${choice}" in
    1)
        run_script "${SCRIPT_DIR}/Scripts/complete.sh"
        ;;
    2)
        run_script "${SCRIPT_DIR}/Scripts/eww.sh"
        ;;
    3)
        run_script "${SCRIPT_DIR}/Scripts/graphic.sh"
        ;;
    4)
        run_script "${SCRIPT_DIR}/Scripts/ulauncher.sh"
        ;;
    5)
        echo "Exiting installation."
        exit 0
        ;;
    *)
        echo "Invalid choice."
        exit 1
        ;;
esac