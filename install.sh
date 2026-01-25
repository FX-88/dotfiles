# THIS IS GONNA BE A BETTER SCRIPT THAT INCLUDES ALL THE "SUB-SCRIPTS" LIKE graphic.sh AND OTHERS

echo "THIS SCRIPT NEEDS TO BE TESTED BEFORE BEING USED IN PRODUCTION"
echo "ARE YOU TESTING THE SCRIPT? (y/n)"
read test_answer
if [[ "$test_answer" =~ ^[Yy]$ ]]; then
    echo "Proceeding with installation..."
else
    echo "Installation aborted."
    exit 1
fi

echo "Choose what you want to install:"
echo "1. Complete installation (graphic environment [polybar + picom] + window manager [i3])"
echo "2. Complete installation (graphic environment [eww + picom] + window manager [i3])"
echo "3. Graphic environment [polybar + picom]"
echo "4. Just ULauncher"
echo "5. Exit"
read choice

if [ "$choice" == "1" ]; then
    chmod +x ./Scripts/complete.sh
    ./Scripts/complete.sh
elif [ "$choice" == "2" ]; then
    chmod +x ./Scripts/eww.sh
    ./Scripts/eww.sh
elif [ "$choice" == "3" ]; then
    chmod +x ./Scripts/graphic.sh
    ./Scripts/graphic.sh
elif [ "$choice" == "4" ]; then
    chmod +x ./Scripts/ulauncher.sh
    ./Scripts/ulauncher.sh
elif [ "$choice" == "5" ]; then
    echo "Exiting installation."
    exit 0
else
    echo "Invalid choice."
fi