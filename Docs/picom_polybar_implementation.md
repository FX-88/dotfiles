# Setup i3 con Polybar e Picom - Stile Hyprland

Guida completa per configurare i3 window manager con un'estetica moderna ispirata a Hyprland su Linux Mint.

## 📋 Prerequisiti

Prima di iniziare, assicurati di avere i3 installato:
```bash
sudo apt install i3
```

## 🔧 Installazione Pacchetti

### 1. Installa Polybar e Picom
```bash
sudo apt update
sudo apt install polybar picom
```

### 2. Installa i Font Necessari
```bash
sudo apt install fonts-jetbrains-mono fonts-font-awesome
```

### 3. (Opzionale) Altri Tool Utili
```bash
# Rofi per launcher moderno
sudo apt install rofi

# Dunst per notifiche stilizzate
sudo apt install dunst

# Nitrogen per gestire lo sfondo
sudo apt install nitrogen

# feh (alternativa a nitrogen)
sudo apt install feh
```

## 📁 Creazione Directory di Configurazione

```bash
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/picom
```

## 📝 File di Configurazione

### 1. Configurazione i3

Copia il contenuto del file di configurazione i3 in:
```bash
~/.config/i3/config
```

**Modifiche importanti da fare:**

Rimuovi o commenta la sezione `bar { }` esistente e aggiungi queste righe alla fine del file:

```bash
# Avvia Polybar
exec_always --no-startup-id ~/.config/polybar/launch.sh

# Avvia Picom
exec_always --no-startup-id picom --config ~/.config/picom/picom.conf

# (Opzionale) Imposta lo sfondo
exec_always --no-startup-id nitrogen --restore
# oppure con feh:
# exec_always --no-startup-id feh --bg-scale /path/to/your/wallpaper.jpg
```

### 2. Configurazione Polybar

Salva il file di configurazione polybar in:
```bash
~/.config/polybar/config.ini
```

### 3. Script di Avvio Polybar

Crea il file `~/.config/polybar/launch.sh`:

```bash
nano ~/.config/polybar/launch.sh
```

Incolla questo contenuto:

```bash
#!/bin/bash

# Termina istanze di polybar in esecuzione
killall -q polybar

# Attendi che i processi si chiudano completamente
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Avvia polybar con log
echo "---" | tee -a /tmp/polybar.log
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar avviata..."
```

Rendi lo script eseguibile:
```bash
chmod +x ~/.config/polybar/launch.sh
```

### 4. Configurazione Picom

Salva il file di configurazione picom in:
```bash
~/.config/picom/picom.conf
```

## ⚙️ Configurazioni Personalizzate

### Modulo Batteria Polybar

Se il modulo batteria non funziona, identifica il nome corretto della tua batteria:

```bash
ls /sys/class/power_supply/
```

Poi modifica nel file `~/.config/polybar/config.ini` la riga:
```ini
battery = BAT0  # Cambia con il nome trovato (es. BAT1)
adapter = AC    # Cambia se necessario (es. ADP1)
```

### Modulo Network Polybar

Per identificare la tua interfaccia di rete:

```bash
ip link show
```

Se usi ethernet invece di wifi, modifica in `config.ini`:
```ini
[module/network]
interface-type = wired  # invece di wireless
```

### Regolazione Opacità Picom

Nel file `~/.config/picom/picom.conf`, puoi modificare l'opacità per applicazioni specifiche:

```conf
opacity-rule = [
  "95:class_g = 'Alacritty'",  # Cambia il valore 95 (95%)
  "90:class_g = 'Thunar'",     # Aggiungi nuove regole
];
```

Per trovare il nome della classe di una finestra:
```bash
xprop | grep WM_CLASS
```
Poi clicca sulla finestra desiderata.

## 🚀 Avvio e Test

### 1. Ricarica i3
Premi `Mod+Shift+R` (di default `Win+Shift+R`) per ricaricare i3.

### 2. Riavvia i3 Completamente
Premi `Mod+Shift+E` e scegli di uscire, poi riaccedi.

### 3. Test Polybar Manuale
Se polybar non appare, prova ad avviarla manualmente:
```bash
~/.config/polybar/launch.sh
```

Controlla eventuali errori con:
```bash
cat /tmp/polybar.log
```

### 4. Test Picom Manuale
```bash
picom --config ~/.config/picom/picom.conf
```

## 🐛 Risoluzione Problemi

### Polybar non si avvia

**Problema:** Lo script non viene eseguito

**Soluzione:**
```bash
# Verifica che lo script sia eseguibile
ls -l ~/.config/polybar/launch.sh

# Se necessario, aggiungi i permessi
chmod +x ~/.config/polybar/launch.sh
```

### Font non visualizzate correttamente

**Problema:** Icone o caratteri strani in polybar

**Soluzione:**
```bash
# Reinstalla i font
sudo apt install --reinstall fonts-font-awesome fonts-jetbrains-mono

# Aggiorna la cache dei font
fc-cache -fv

# Riavvia polybar
~/.config/polybar/launch.sh
```

### Picom causa lag o problemi grafici

**Problema:** Performance scarse o glitch visivi

**Soluzione:** Modifica `~/.config/picom/picom.conf`:
```conf
# Disabilita il blur se causa problemi
blur-background = false;

# Oppure usa un backend diverso
backend = "xrender";  # invece di "glx"
```

### Angoli arrotondati non funzionano

**Problema:** Le finestre hanno ancora angoli quadrati

**Soluzione:** La versione di picom su Mint potrebbe non supportare `corner-radius`. Puoi:

1. Commentare la riga nel config:
```conf
# corner-radius = 10;
```

2. Oppure compilare picom-git manualmente (vedi sezione Avanzate)

### Modulo batteria non funziona

**Problema:** Il modulo batteria non appare

**Soluzione:**
```bash
# Verifica il nome della batteria
ls /sys/class/power_supply/

# Modifica config.ini con il nome corretto
nano ~/.config/polybar/config.ini
```

## 🎨 Personalizzazione Colori

I colori sono definiti nella sezione `[colors]` di `~/.config/polybar/config.ini`:

```ini
[colors]
background = #1e1e2e      ; Sfondo principale
primary = #89b4fa         ; Colore primario (blu)
secondary = #f5c2e7       ; Colore secondario (rosa)
alert = #f38ba8           ; Colore di allerta (rosso)
green = #a6e3a1           ; Verde
yellow = #f9e2af          ; Giallo
```

Modifica questi valori esadecimali per cambiare lo schema colori.

## 📚 Configurazioni Avanzate

### Compilare Picom-git (per animazioni avanzate)

Se vuoi animazioni più fluide e funzionalità aggiuntive:

```bash
# Installa dipendenze
sudo apt install meson ninja-build libconfig-dev libdbus-1-dev \
  libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev \
  libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev \
  libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev \
  libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev \
  libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev \
  libxcb-xfixes0-dev uthash-dev

# Clona il repository
cd ~/Downloads
git clone https://github.com/yshui/picom.git
cd picom

# Compila e installa
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

# Riavvia picom
killall picom
picom --config ~/.config/picom/picom.conf &
```

### Usare Rofi invece di dmenu

Aggiungi nel config i3:
```bash
# Sostituisci il binding di dmenu con rofi
bindsym $mod+d exec --no-startup-id rofi -show drun
```

### Aggiungere moduli personalizzati a Polybar

Esempio di modulo temperatura CPU:

```ini
[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 70

format = <ramp> <label>
format-warn = <ramp> <label-warn>

label = %temperature-c%
label-warn = %temperature-c%
label-warn-foreground = ${colors.alert}

ramp-0 = 
ramp-1 = 
ramp-2 = 
```

Poi aggiungilo in `[bar/main]`:
```ini
modules-right = pulseaudio memory cpu temperature network battery
```

## 📖 Risorse Utili

- [Documentazione i3](https://i3wm.org/docs/)
- [Wiki Polybar](https://github.com/polybar/polybar/wiki)
- [Picom Repository](https://github.com/yshui/picom)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)

## 💡 Tips

1. **Backup delle configurazioni originali** prima di sostituirle
2. **Testa le modifiche** ricaricando i3 prima di riavviare
3. **Controlla i log** in `/tmp/polybar.log` per debug
4. **Usa** `xprop` per identificare classi delle finestre
5. **Premi** `Mod+Shift+C` per ricaricare solo il config senza riavviare

## ✅ Checklist Finale

- [ ] i3, polybar e picom installati
- [ ] Font installati
- [ ] Directory create
- [ ] File di configurazione copiati
- [ ] Script launch.sh creato ed eseguibile
- [ ] Comandi exec_always aggiunti al config i3
- [ ] i3 riavviato
- [ ] Polybar visibile
- [ ] Effetti picom attivi (blur, ombre, angoli)
- [ ] Tutti i moduli polybar funzionanti

---

**Buona configurazione! 🚀**

Per domande o problemi, controlla sempre i log e la documentazione ufficiale.