#THIS INSTALLATION SCRIPT IS JUST FOR THE GRAPHIC PART, IT DOES NOT INCLUDE THE WINDOW MANAGER SETUP

echo "THIS SCRIPT NEEDS TO BE TESTED BEFORE BEING USED IN PRODUCTION"
echo "ARE YOU TESTING THE SCRIPT? (y/n)"
read test_answer
if [ "$test_answer" == "${test_answer#[Yy]}" ] ;then
    continue
else
    echo "Installation aborted."
    exit 1
fi


echo "THIS SCRIPT WILL ONLY SETUP THE GRAPHIC ENVIRONMENT. DO YOU WISH TO CONTINUE? (y/n)"
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
    continue
else
    echo "Installation aborted."
    exit 1
fi

#Updating system packages
echo "Starting installation"
echo "Updating the system packages"
sudo apt update && sudo apt upgrade -y

#Install packages
sudo apt install git eww polybar fonts-jetbrains-mono fonts-font-awesome build-essential libgtk-3-dev libgtk-layer-shell-dev pamixer xdotool jq
echo "Installed necessary packages and dependencies."


#Install picom from source#
echo "Installing picom from source..."
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev
git clone https://github.com/yshui/picom && cd picom
meson --buildtype=release . build
ninja -C build
cp build/src /usr/local/bin
echo "Everythin is installed. Setting up directories"


#If configuration directories do not exist, create them and copy configuration files#
if ([ ! -d "$HOME/.config/picom" ] || [ ! -d "$HOME/.config/polybar" ]); then
    #Create configuration directories if they don't exist#

    #IF YOU WANT TO USE EWW, UNCOMMENT THE LINES BELOW#
    #if ([ ! -d "$HOME/.config/eww" ]); then
    #    mkdir -p $HOME/.config/eww
    #    #cp -r ./eww/* $HOME/.config/eww/
    #    echo "Finished copying eww configuration files."
    #fi

    if ([ ! -d "$HOME/.config/picom" ]); then
        mkdir -p $HOME/.config/picom
        cp ~/dotfiles/picom/picom.conf $HOME/.config/picom/picom.conf
        echo "Finished copying picom configuration files."
    fi

    if ([ ! -d "$HOME/.config/polybar" ]); then
        mkdir -p $HOME/.config/polybar
        cp ~/dotfiles/polybar/launch.sh $HOME/.config/polybar/launch.sh
        echo "Finished copying polybar configuration files."
    fi
fi
else
    #Copy configuration files#
    cp ~/dotfiles/picom/picom.conf $HOME/.config/picom/picom.conf
    cp ~/dotfiles/polybar/launch.sh $HOME/.config/polybar/launch.sh
    echo "Configuration files copied"
fi 


#If you want to make the launch script executable, uncomment the line below
#chmod +x ~/.config/polybar/launch.sh

#IF YOU WANT TO USE EWW, UNCOMMENT THE LINES BELOW#
#cp ~/dotfiles/eww/eww.rasi $HOME/.config/eww/


echo "Do you wish to install ulauncher as an application launcher? (y/n)"
read ulauncher_answer
if [ "$ulauncher_answer" == "${ulauncher_answer#[Yy]}" ] ;then
    chmod +x ./ulauncher.sh
    ./ulauncher.sh
fi

echo "Installation complete! Please restart your session to apply the changes."
# Note: Additional steps may be required to fully configure the environment.