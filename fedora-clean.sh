#!/bin/bash
echo "🚀 Avvio manutenzione di Fedora..."

# Aggiorna i pacchetti DNF e il sistema
echo "🔄 Aggiornamento pacchetti di sistema..."
sudo dnf upgrade --refresh -y

# Rimuove i pacchetti orfani (non più necessari)
echo "🧹 Rimozione pacchetti inutilizzati..."
sudo dnf autoremove -y

# Pulisce la cache di DNF per liberare spazio
echo "🗑️ Pulizia cache DNF..."
sudo dnf clean all

# Aggiorna e pulisce i Flatpak orfani
if command -v flatpak &> /dev/null; then
    echo "📦 Aggiornamento Flatpak..."
    flatpak update -y
    echo "🧹 Rimozione Flatpak inutilizzati..."
    flatpak uninstall --unused -y
fi

echo "✅ Sistema aggiornato e pulito con successo!"
