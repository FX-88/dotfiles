# This is a dotfile configuration for Linux Mint to make it look like Hyprland

##

### Tested on=

- Linux Mint 22.2;
- Debian (partially);

>THIS DOTFILE IS JUST FOR ME TO HAVE THE CONFIGURATION ACROSS ALL MY DEVICES

### It includes the WM i3 for its customisation

>DEBIAN-based ONLY

---

For the installation of the dotfile :

### For the complete install script

```bash
git clone https://github.com/FX-88/dotfiles.git
```

---

```bash
cd dotfiles
```

---

In order to make the .sh executable you need to make this command :

```bash
chmod +x ./install.sh
```

---

```bash
./install.sh
```

---

### Remember, if you install ulauncher, also add it on the exec.conf file to start it everytime

>#exec --no-startup-id ulauncher

---

### If polybar has problems with its execution

Un-comment the second line on the exec.conf into the i3 directory :

>#exec --no-startup-id ~/.config/polybar/launch.sh

And comment the following line :

>exec --no-startup-id polybar

---

### Eww startup

To run eww (commands from the official docs) execute this commands :

```bash
./eww daemon
```

``` bash
./eww open <window_name>
```

---

Additional Infos :

>Additional steps may be needed to fully implement the dotfile confguration

>Almost every comment line in this dotfile is made in italian (my native languadge), but some of them are in english

>This repo contains code from other repositories as inspiration =
>https://github.com/CrescentMnn/dotfiles.git and https://github.com/dharmx/walls.git
