#This is a temporary installation script for setting up the project environment
#IT'S NOT READY FOR PRODUCTION USE

sudo apt update && sudo apt upgrade -y

sudo apt install i3 eww picom polybar 

if ([ ! -d "$HOME/.config/i3" ]); then
    mkdir -p $HOME/.config/i3
    cp -r ./i3/* $HOME/.config/i3/
fi

if ([ ! -d "$HOME/.config/eww" ]); then
    mkdir -p $HOME/.config/eww
    cp -r ./eww/* $HOME/.config/eww/
fi

if ([ ! -d "$HOME/.config/picom" ]); then
    mkdir -p $HOME/.config/picom
    cp -r ./picom/* $HOME/.config/picom/
fi

if ([ ! -d "$HOME/.config/polybar" ]); then
    mkdir -p $HOME/.config/polybar
    cp -r ./polybar/* $HOME/.config/polybar/
fi

echo "Installation complete! Please restart your session to apply the changes."
# Note: Additional steps may be required to fully configure the environment.