# Setup Eww per i3 - Stile Hyprland

Guida completa per configurare Eww (Elkowar's Wacky Widgets) come alternativa a Polybar con un'estetica moderna ispirata a Hyprland.

## 📋 Cos'è Eww?

Eww è un widget engine estremamente personalizzabile che permette di creare bar, pannelli, dashboard e qualsiasi tipo di widget per il tuo desktop. A differenza di Polybar, Eww richiede più configurazione ma offre flessibilità illimitata.

## ⚠️ Nota Importante

Eww è più complesso di Polybar. Se vuoi qualcosa di rapido e funzionale, **usa Polybar**. Usa Eww solo se:
- Ti piace personalizzare tutto nei minimi dettagli
- Non ti spaventa imparare un nuovo linguaggio di configurazione
- Vuoi creare widget oltre alla semplice bar

## 🔧 Installazione

### Opzione 1: Compilazione da Sorgente (Raccomandato)

Eww non è disponibile nei repository standard di Linux Mint, quindi va compilato:

```bash
# Installa Rust (necessario per compilare Eww)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# Installa dipendenze
sudo apt update
sudo apt install build-essential libgtk-3-dev libgtk-layer-shell-dev

# Clona e compila Eww
cd ~/Downloads
git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features x11

# Installa il binario
sudo cp target/release/eww /usr/local/bin/

# Verifica installazione
eww --version
```

### Opzione 2: Download Binary Precompilato

Se non vuoi compilare:

```bash
# Scarica l'ultima release da GitHub
cd ~/Downloads
wget https://github.com/elkowar/eww/releases/latest/download/eww-x86_64-unknown-linux-musl
chmod +x eww-x86_64-unknown-linux-musl
sudo mv eww-x86_64-unknown-linux-musl /usr/local/bin/eww

# Verifica
eww --version
```

## 📦 Dipendenze Aggiuntive

Installa i tool necessari per i moduli:

```bash
# jq per parsing JSON
sudo apt install jq

# xdotool per info finestre
sudo apt install xdotool

# pamixer per controllo volume
sudo apt install pamixer

# network-manager per info rete
sudo apt install network-manager

# Font
sudo apt install fonts-jetbrains-mono fonts-font-awesome
```

## 📁 Setup Configurazione

### 1. Crea la directory di configurazione

```bash
mkdir -p ~/.config/eww
```

### 2. Crea i file di configurazione

Crea i seguenti file:

**~/.config/eww/eww.yuck** - File di configurazione principale (già fornito nell'artifact)

**~/.config/eww/eww.scss** - File di stile CSS (già fornito nell'artifact)

### 3. Verifica il nome della batteria

Se il modulo batteria non funziona:

```bash
ls /sys/class/power_supply/
```

Se la tua batteria non si chiama `BAT0`, modifica `eww.yuck`:

```lisp
;; Cambia BAT0 con il nome trovato (es. BAT1)
(defpoll battery-percentage :interval "5s"
  `cat /sys/class/power_supply/TUO_NOME_BATTERIA/capacity 2>/dev/null || echo "100"`)
```

## 🚀 Avvio Eww

### Test Manuale

Prima di avviare Eww automaticamente, testa se funziona:

```bash
# Avvia il daemon
eww daemon

# Apri la bar
eww open bar

# Chiudi la bar
eww close bar

# Ferma il daemon
eww kill
```

### Script di Avvio Automatico

Crea lo script `~/.config/eww/launch.sh`:

```bash
#!/bin/bash

# Chiudi istanze precedenti
eww kill

# Avvia il daemon
eww daemon

# Attendi che il daemon sia pronto
sleep 1

# Apri la bar
eww open bar
```

Rendi eseguibile:

```bash
chmod +x ~/.config/eww/launch.sh
```

### Integrazione con i3

Modifica `~/.config/i3/config`:

```bash
# Commenta la sezione bar di i3
# bar { ... }

# Avvia Eww
exec_always --no-startup-id ~/.config/eww/launch.sh

# Mantieni Picom per gli effetti
exec_always --no-startup-id picom --config ~/.config/picom/picom.conf
```

Ricarica i3: `Mod+Shift+R`

## 🎨 Personalizzazione

### Modificare i Colori

Modifica `eww.scss`:

```css
@define-color primary #89b4fa;    /* Cambia il colore primario */
@define-color background #1e1e2e; /* Cambia lo sfondo */
```

Dopo le modifiche:
```bash
eww reload
```

### Aggiungere Nuovi Widget

Esempio: widget uptime nel file `eww.yuck`:

```lisp
;; Polling uptime
(defpoll uptime :interval "60s"
  `uptime -p | sed 's/up //'`)

;; Widget uptime
(defwidget uptime-widget []
  (box :class "uptime"
       :orientation "h"
       :spacing 5
    (label :text "")
    (label :text "${uptime}")))
```

Aggiungi alla bar:

```lisp
(box :class "bar-section-right"
     :orientation "h"
     :spacing 10
  (uptime-widget)  ;; Nuovo widget
  (volume-widget)
  (cpu)
  ...)
```

### Modificare Intervalli di Aggiornamento

In `eww.yuck`, cambia `:interval`:

```lisp
;; Aggiorna ogni 5 secondi invece di 2
(defpoll cpu-usage :interval "5s"
  `top -bn1 | grep "Cpu(s)" | sed "s/.*, *\\([0-9.]*\\)%* id.*/\\1/" | awk '{print 100 - $1}'`)
```

## 🐛 Risoluzione Problemi

### Eww non si avvia

**Problema:** Errore "eww: command not found"

**Soluzione:**
```bash
# Verifica che eww sia in PATH
which eww

# Se non trovato, aggiungi al PATH
echo 'export PATH="$PATH:/usr/local/bin"' >> ~/.bashrc
source ~/.bashrc
```

### Bar non appare

**Problema:** Il daemon parte ma la bar non è visibile

**Soluzione:**
```bash
# Verifica errori
eww logs

# Riavvia tutto
eww kill
eww daemon
eww open bar
```

### Workspace i3 non funzionano

**Problema:** I workspace non vengono mostrati o sono vuoti

**Soluzione:**
```bash
# Verifica che i3-msg funzioni
i3-msg -t get_workspaces

# Installa jq se mancante
sudo apt install jq

# Test del comando direttamente
i3-msg -t get_workspaces | jq -c '.[]'
```

### Icone non visualizzate

**Problema:** Invece delle icone vedi quadrati o caratteri strani

**Soluzione:**
```bash
# Installa Font Awesome
sudo apt install fonts-font-awesome

# Aggiorna cache font
fc-cache -fv

# Riavvia Eww
eww kill
eww daemon
eww open bar
```

### Modulo volume non funziona

**Problema:** Il volume non viene mostrato

**Soluzione:**
```bash
# Installa pamixer
sudo apt install pamixer

# Test manuale
pamixer --get-volume

# Se non funziona, usa alternative in eww.yuck:
# pactl per PulseAudio
(defpoll volume :interval "1s"
  `pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\\d+(?=%)' | head -1`)
```

### CPU/RAM mostrano valori strani

**Problema:** Percentuali errate o "nan"

**Soluzione:**
```bash
# Verifica i comandi manualmente
top -bn1 | grep "Cpu(s)"
free | grep Mem

# Se necessario, usa alternative:
# CPU con mpstat
(defpoll cpu-usage :interval "2s"
  `mpstat 1 1 | awk '/Average:/ {print 100 - $NF}'`)
```

## 🎯 Funzionalità Avanzate

### Aggiungere Click agli Widget

Esempio: click sul volume per aprire pavucontrol:

```lisp
(defwidget volume-widget []
  (eventbox :onclick "pavucontrol &"
    (box :class "volume"
         :orientation "h"
         :spacing 5
      (label :text {volume-muted == "true" ? "" : ""})
      (label :text "${volume}%"))))
```

### Creare Popup/Tooltip Personalizzati

```lisp
;; Finestra popup per calendario
(defwindow calendar-popup
  :monitor 0
  :geometry (geometry :x "0"
                      :y "35px"
                      :width "300px"
                      :height "200px"
                      :anchor "top right")
  :stacking "overlay"
  (box (label :text "Popup personalizzato!")))
```

Apri con:
```bash
eww open calendar-popup
```

### Dashboard Completa

Eww può creare dashboard complete oltre alla bar. Esempio in `eww.yuck`:

```lisp
(defwindow dashboard
  :monitor 0
  :geometry (geometry :x "50%"
                      :y "50%"
                      :width "600px"
                      :height "400px"
                      :anchor "center")
  :stacking "overlay"
  (box :class "dashboard"
       :orientation "v"
       :spacing 20
    (label :text "Dashboard")
    (box :orientation "h"
         :spacing 10
      (cpu)
      (memory))
    (volume-widget)
    (datetime)))
```

Toggle con: `eww open dashboard` / `eww close dashboard`

## 📊 Comparazione: Eww vs Polybar

| Caratteristica | Polybar | Eww |
|----------------|---------|-----|
| Facilità setup | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| Flessibilità | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Moduli predefiniti | ⭐⭐⭐⭐⭐ | ⭐ |
| Widget custom | ⭐ | ⭐⭐⭐⭐⭐ |
| Documentazione | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Community | ⭐⭐⭐⭐ | ⭐⭐⭐ |

## 💡 Consigli

1. **Inizia con Polybar** se è la tua prima configurazione
2. **Passa a Eww** quando vuoi più controllo e personalizzazione
3. **Testa i comandi** nel terminale prima di metterli in `eww.yuck`
4. **Usa `eww logs`** per debug in tempo reale
5. **Consulta gli esempi** su [r/unixporn](https://reddit.com/r/unixporn)

## 📚 Risorse Utili

- [Documentazione Eww](https://elkowar.github.io/eww/)
- [Repository GitHub](https://github.com/elkowar/eww)
- [Esempi Community](https://github.com/elkowar/eww/discussions)
- [Eww Wiki](https://github.com/elkowar/eww/wiki)

## ✅ Checklist Setup

- [ ] Rust installato
- [ ] Eww compilato o binario scaricato
- [ ] Dipendenze installate (jq, xdotool, pamixer)
- [ ] Directory ~/.config/eww creata
- [ ] File eww.yuck e eww.scss copiati
- [ ] Script launch.sh creato ed eseguibile
- [ ] Nome batteria verificato
- [ ] Test manuale: `eww daemon && eww open bar`
- [ ] Integrazione i3 configurata
- [ ] Bar visibile e funzionante

---

**Buona configurazione con Eww! 🎨**

Per setup più avanzati, esplora i widget personalizzati e crea il tuo ambiente desktop unico!