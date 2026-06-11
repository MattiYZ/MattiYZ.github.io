#!/bin/bash
echo "🚀 Avvio manutenzione di Arch Linux..."

# Aggiorna i pacchetti ufficiali e dell'AUR
echo "🔄 Aggiornamento totale del sistema..."
if command -v yay &> /dev/null; then
    yay -Syu --noconfirm
else
    sudo pacman -Syu --noconfirm
fi

# Rimuove i pacchetti orfani (isolati e non più richiesti da nessuno)
echo "🧹 Rimozione pacchetti orfani..."
if [ -n "$(pacman -Qtdq)" ]; then
    sudo pacman -Rns $(pacman -Qtdq) --noconfirm
else
    echo "Nessun pacchetto orfano da rimuovere."
fi

# Pulisce la cache dei pacchetti tenendo solo gli ultimi due (sicurezza in caso di downgrade)
echo "🗑️ Pulizia cache dei pacchetti vecchi..."
sudo pacman -Scc --noconfirm

# Aggiorna e pulisce i Flatpak orfani
if command -v flatpak &> /dev/null; then
    echo "📦 Aggiornamento Flatpak..."
    flatpak update -y
    echo "🧹 Rimozione Flatpak inutilizzati..."
    flatpak uninstall --unused -y
fi

echo "✅ Arch Linux aggiornato e ottimizzato!"
