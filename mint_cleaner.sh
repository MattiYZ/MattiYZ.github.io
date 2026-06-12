#!/bin/bash
# =================================================================
# Script Name:  Linux Mint System Cleaner
# Developer:    MattiYZ (TikTok: @mattiateeck)
# Description:  Automated APT, Flatpak, and cache maintenance
# Repository:   github.com/MattiYZ
# =================================================================

clear
echo "========================================="
echo "    STARTING LINUX MINT CLEANUP...       "
echo "========================================="

# 1. Update repositories and packages
echo -e "\n[1/5] Updating package repositories and system..."
sudo apt update && sudo apt upgrade -y

# 2. Remove unused dependencies and packages
echo -e "\n[2/5] Removing unneeded packages and dependencies..."
sudo apt autoremove -y

# 3. Clean APT local repository cache
echo -e "\n[3/5] Cleaning cached package files..."
sudo apt clean && sudo apt autoclean

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
echo "   ✅ LINUX MINT CLEANUP COMPLETED!      "
echo "========================================="
