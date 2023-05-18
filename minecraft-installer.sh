#!/bin/bash
ARCHIVE_LINE=$(awk '/^__ARCHIVE_BEGINS__/ { print NR + 1; exit 0; }' $0)
PREVIOUS_WORKING_DIRECTORY=$PWD

# Get Minecraft
sudo mkdir -p /tmp/minecraft-installer
cd /tmp/minecraft-installer
sudo wget -qO ./minecraft.tar.gz "https://launcher.mojang.com/download/Minecraft.tar.gz"
# Extract Minecraft and included archive
sudo tar -xzf ./minecraft.tar.gz
tail -n +${ARCHIVE_LINE} $0 | tar -zpvx -C /tmp/minecraft-installer/
# Install into proper folders
sudo mkdir -p /usr/share/minecraft
sudo install -Dm 644 ./minecraft-launcher/minecraft-launcher /usr/share/minecraft/minecraft-launcher
sudo install -Dm 644 ./archive/Minecraft.desktop /usr/share/applications/Minecraft.desktop
sudo install -Dm 644 ./archive/minecraft.svg /usr/share/pixmaps/minecraft.svg
# Symlink minecraft-launcher into /bin
sudo ln -sf /usr/share/minecraft/minecraft-launcher /bin/minecraft-launcher

# Clean up
cd "$PREVIOUS_WORKING_DIRECTORY"
sudo rm -r /tmp/minecraft-installer
exit 0

__ARCHIVE_BEGINS__