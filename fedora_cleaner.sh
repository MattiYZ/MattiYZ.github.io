#!/bin/bash
# =================================================================
# Script Name:  Fedora System Cleaner
# Developer:    MattiYZ (TikTok: @mattiateeck)
# Description:  Automated DNF, Flatpak, and journal maintenance
# Repository:   github.com/MattiYZ
# =================================================================

clear
echo "========================================="
echo "   STARTING FEDORA SYSTEM CLEANUP...    "
echo "========================================="

# 1. Upgrade and sync repositories
echo -e "\n[1/5] Checking for system and repository updates..."
sudo dnf upgrade --refresh -y

# 2. Remove unused and orphan packages
echo -e "\n[2/5] Removing unused dependencies and orphan packages..."
sudo dnf autoremove -y

# 3. Clean DNF package cache
echo -e "\n[3/5] Cleaning DNF package manager cache..."
sudo dnf clean all

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
echo "   ✅ FEDORA SYSTEM CLEANUP COMPLETED!   "
echo "========================================="
