#This is a temporary installation script for setting up the project environment
#IT'S NOT READY FOR PRODUCTION USE


echo "THIS SCRIPT WILL INSTALL THE WM AND ITS DEPENDENCIES, THIS INCLUDES COPYING FILES TO YOUR HOME DIRECTORY"
echo "DO YOU WISH TO CONTINUE? (y/n)"
read response
if [ "$response" == "${response#[Yy]}" ] ;then
    wait 2s
    continue
else
    echo "Installation aborted."
    wait 0.5s
    exit 1
fi



echo "Starting installation..."
echo "Updating system packages..."
#Update and upgrade system packages#
sudo apt update && sudo apt upgrade -y

#Install necessary packages#
sudo apt install git i3 feh fonts-jetbrains-mono fonts-font-awesome build-essential libgtk-3-dev libgtk-layer-shell-dev pamixer xdotool jq
echo "Installed necessary packages and dependencies."

#Install picom from source#
echo "Installing picom from source..."
cd ~/dotfiles
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev
git clone https://github.com/yshui/picom && cd picom
meson --buildtype=release . build
ninja -C build
cp build/src /usr/local/bin
echo "picom installation complete."

#Installing eww from source#
echo "Installing eww from source..."
cd ~/dotfiles
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt install gtk3 pango libdbusmenu-gtk3cairo glib2 libgio, libglib-2, libgobject-2 gcc-libs libgcc glibc
git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features x11
cd target/release
chmod +x ./eww


echo "Everythin is installed. Setting up directories"


#If configuration directories do not exist, create them and copy configuration files#
if ([ ! -d "$HOME/.config/i3" ] || [ ! -d "$HOME/.config/picom" ] || [ ! -d "$HOME/.config/eww" ]); then
    #Create configuration directories if they don't exist#
    if ([ ! -d "$HOME/.config/i3" ]); then
        mkdir -p $HOME/.config/i3
        cp ~/dotfiles/i3/config $HOME/.config/i3/config
        cp ~/dotfiles/i3/exec.conf $HOME/.config/i3/exec.conf
        cp ~/dotfiles/i3/keybinds.conf $HOME/.config/i3/keybinds.conf
        cp ~/dotfiles/i3/window_control.conf $HOME/.config/i3/window_control.conf
        echo "Finished copying i3 configuration files."
    fi

    #IF YOU WANT TO USE EWW, UNCOMMENT THE LINES BELOW#
    if ([ ! -d "$HOME/.config/eww" ]); then
        mkdir -p $HOME/.config/eww
        cp ./eww/* $HOME/.config/eww/
        echo "Finished copying eww configuration files."
    fi

    if ([ ! -d "$HOME/.config/picom" ]); then
        mkdir -p $HOME/.config/picom
        cp ~/dotfiles/picom/picom.conf $HOME/.config/picom/picom.conf
        echo "Finished copying picom configuration files."
    fi
fi
else
    #Copy configuration files#
    cp ~/dotfiles/i3/* $HOME/.config/i3/*
    cp ~/dotfiles/picom/picom.conf $HOME/.config/picom/picom.conf
    cp ~/dotfiles/eww/* $HOME/.config/eww/*
fi 

echo "Do you wish to install ulauncher as an application launcher? (y/n)"
read ulauncher_answer
if [ "$ulauncher_answer" == "${ulauncher_answer#[Yy]}" ] ;then
    chmod +x ./Scripts/ulauncher.sh
    ./Scripts/ulauncher.sh
fi

echo "Installation complete! Please restart your session to apply the changes."
# Note: Additional steps may be required to fully configure the environment.