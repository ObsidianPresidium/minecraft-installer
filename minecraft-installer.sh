#!/bin/bash
ARCHIVE_LINE=$(awk '/^__ARCHIVE__/ { print NR + 1; exit 0; }' $0)

PREVIOUS_WORKING_DIRECTORY=$PWD

# Get Minecraft
sudo mkdir -p /tmp/minecraft-installer
# Extract included archive. This must be done before any cd commands.
sudo bash -c "tail -n +${ARCHIVE_LINE} $0 | base64 -d | tar -zpx -C /tmp/minecraft-installer/"
cd /tmp/minecraft-installer
sudo wget -qO ./minecraft.tar.gz "https://launcher.mojang.com/download/Minecraft.tar.gz"
# Extract Minecraft
sudo tar -xzf ./minecraft.tar.gz
# Install into proper folders
sudo mkdir -p /usr/share/minecraft
sudo install -Dm 755 ./minecraft-launcher/minecraft-launcher /usr/share/minecraft/minecraft-launcher
sudo install -Dm 644 ./archive/Minecraft.desktop /usr/share/applications/Minecraft.desktop
sudo install -Dm 644 ./archive/minecraft.svg /usr/share/pixmaps/minecraft.svg
# Symlink minecraft-launcher into /bin
sudo ln -sf /usr/share/minecraft/minecraft-launcher /bin/minecraft-launcher

# Clean up
cd "$PREVIOUS_WORKING_DIRECTORY"
sudo rm -r /tmp/minecraft-installer

echo "Done! Minecraft should now be installed. You can open it with your usual menu system, or by executing minecraft-launcher in a terminal."
exit 0

# This next line must have a newline after it.
__ARCHIVE__
