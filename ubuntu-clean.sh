#!/bin/bash
echo "🚀 Avvio manutenzione di Ubuntu/Mint..."

# Aggiorna l'elenco dei pacchetti e aggiorna il sistema
echo "🔄 Aggiornamento pacchetti di sistema..."
sudo apt update && sudo apt upgrade -y

# Rimuove le dipendenze inutilizzate e i vecchi kernel non più necessari
echo "🧹 Rimozione pacchetti orfani e vecchi file..."
sudo apt autoremove -y

# Pulisce i file parziali o residui dei pacchetti scaricati
echo "🗑️ Pulizia della cache di APT..."
sudo apt clean
sudo apt autoclean

# Aggiorna e pulisce i Flatpak orfani
if command -v flatpak &> /dev/null; then
    echo "📦 Aggiornamento Flatpak..."
    flatpak update -y
    echo "🧹 Rimozione Flatpak inutilizzati..."
    flatpak uninstall --unused -y
fi

echo "✅ Sistema aggiornato e pulito!"
