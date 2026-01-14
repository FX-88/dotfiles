#This is a temporary installation script for setting up the project environment
#IT'S NOT READY FOR PRODUCTION USE

sudo apt update && sudo apt upgrade -y

sudo apt install i3 eww picom polybar stow fonts-jetbrains-mono fonts-font-awesome build-essential libgtk-3-dev libgtk-layer-shell-dev pamixer xdotool jq

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

# Use stow to manage .config files 
# It automatically links files from the project directory to the home directory

cp ~/dotfiles/i3/config ~/.config/i3/config
cp ~/dotfiles/i3/exec.conf ~/.config/i3/exec.conf
cp ~/dotfiles/i3/keybinds.conf ~/.config/i3/keybinds.conf
cp ~/dotfiles/i3/window_control.conf ~/.config/i3/window_control.conf
cp ~/dotfiles/picom/picom.conf ~/.config/picom/picom.conf
cp ~/dotfiles/polybar/launch.sh ~/.config/polybar/launch.sh

#If you want to make the launch script executable, uncomment the line below
#chmod +x ~/.config/polybar/launch.sh


echo "Installation complete! Please restart your session to apply the changes."
# Note: Additional steps may be required to fully configure the environment.