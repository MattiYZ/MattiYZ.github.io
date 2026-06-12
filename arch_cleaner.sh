#!/bin/bash
# =================================================================
# Script Name:  Arch Linux System Cleaner
# Developer:    MattiYZ (TikTok: @mattiateeck)
# Description:  Automated Pacman, Cache, and Flatpak maintenance
# Repository:   github.com/MattiYZ
# =================================================================

clear
echo "========================================="
echo "     STARTING ARCH LINUX CLEANUP...      "
echo "========================================="

# 1. Update system databases and packages
echo -e "\n[1/5] Syncing repositories and upgrading system..."
sudo pacman -Syu --noconfirm

# 2. Remove orphan packages (if any exist)
echo -e "\n[2/5] Checking and removing orphan packages..."
if [ -n "$(pacman -Qdtq)" ]; then
    sudo pacman -Rns $(pacman -Qdtq) --noconfirm
else
    echo "No orphan packages found."
fi

# 3. Clean Pacman cache (keeps only the latest installed version)
echo -e "\n[3/5] Cleaning Pacman package cache..."
sudo pacman -Scc --noconfirm

# 4. Clean unused Flatpak runtimes
echo -e "\n[4/5] Cleaning unused Flatpak packages and runtimes..."
if command -v flatpak &> /dev/null; then
    flatpak uninstall --unused -y
else
    echo "Flatpak is not installed, skipping..."
fi

# 5. Vacuum systemd journal logs
echo -e "\n[5/5] Clearing system journal logs older than 7 days..."
sudo journalctl --vacuum-time=7d

echo -e "\n========================================="
echo "   ✅ ARCH LINUX CLEANUP COMPLETED!     "
echo "========================================="
