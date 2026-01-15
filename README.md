# This is a dotfile configuration for Linux Mint to make it look like Hyprland

## IT NEEDS TO BE TESTED, IT'S NOT READY FOR IMPLEMENTATION

>THIS DOTFILE IS JUST FOR THE TO HAVE THE CONFIGURATION ACROSS ALL MY DEVICES

### It includes the WM i3 for its customisation

>DEBIAN ONLY

---

For the installation of the dotfile :

### For the complete install script

```bash
git clone https://github.com/FX-88/dotfiles.git
```

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

Additional Infos :
>This dotfile includes the eww config (it need to be enabled on the complete install script by un-commenting its lines)
>Almost every comment line in this dotfile is made in italian (my native languadge), but some of them are in english
