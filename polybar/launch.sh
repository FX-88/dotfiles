killall -q polybar

# Attendi che i processi si chiudano completamente
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Avvia polybar con log
echo "---" | tee -a /tmp/polybar.log
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar avviata..."