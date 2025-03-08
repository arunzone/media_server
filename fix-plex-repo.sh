#!/bin/bash
# Script to fix Plex repository issues

set -e

echo "Fixing Plex repository issues..."

# Remove all existing Plex repository files
sudo rm -f /etc/apt/sources.list.d/plexmediaserver.list
sudo rm -f /etc/apt/sources.list.d/plexmediaserver*.list

# Remove any Plex entries from main sources.list
sudo sed -i '/downloads\.plex\.tv/d' /etc/apt/sources.list

# Check all source files for Plex entries
echo "Checking all source files for Plex entries..."
for file in /etc/apt/sources.list.d/*.list; do
  if [ -f "$file" ]; then
    if grep -q "downloads.plex.tv" "$file"; then
      echo "Found Plex entry in $file, removing..."
      sudo rm -f "$file"
    fi
  fi
done

# Clean APT cache
echo "Cleaning APT cache..."
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

# Create a clean keyring directory
echo "Setting up clean keyring..."
sudo mkdir -p /usr/share/keyrings
sudo rm -f /usr/share/keyrings/plexmediaserver.gpg

# Download and install Plex key properly
echo "Installing Plex repository key..."
wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O /tmp/PlexSign.key
cat /tmp/PlexSign.key | sudo gpg --dearmor > /tmp/plexmediaserver.gpg
sudo mv /tmp/plexmediaserver.gpg /usr/share/keyrings/plexmediaserver.gpg
sudo chmod 644 /usr/share/keyrings/plexmediaserver.gpg

# Add the repository correctly
echo "Adding Plex repository correctly..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/plexmediaserver.gpg] https://downloads.plex.tv/repo/deb public main" | sudo tee /etc/apt/sources.list.d/plexmediaserver.list

# Update APT
echo "Updating APT..."
sudo apt-get update

echo "Plex repository fix completed!"
