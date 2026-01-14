# This is the OLD method to install picom 

# All of this has been implemented into the main install.sh 


Process to install picom from source on a Debian-based system#
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev

git clone https://github.com/yshui/picom && cd picom

meson --buildtype=release . build

ninja -C build

cp build/src /usr/local/bin

To run picom in the background : picom & 
