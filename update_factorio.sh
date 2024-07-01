#!/bin/bash

# Variables
FACTORIO_DIR="/opt/factorio"
BACKUP_DIR="/opt/factorio_backup"
SERVICE_NAME="factorio"
FACTORIO_URL="https://www.factorio.com/get-download/latest/headless/linux64"

# Stop Factorio service
echo "Stopping Factorio service..."
sudo systemctl stop $SERVICE_NAME

# Create a backup
echo "Creating a backup..."
sudo mkdir -p $BACKUP_DIR
sudo tar -czf $BACKUP_DIR/factorio_backup_$(date +%F).tar.gz -C $FACTORIO_DIR .

# Download latest version of Factorio
echo "Downloading the latest version of Factorio..."
wget $FACTORIO_URL -O /tmp/factorio_headless.tar.xz

# Extract the downloaded file
echo "Updating Factorio..."
sudo tar -xf /tmp/factorio_headless.tar.xz -C $FACTORIO_DIR --strip-components=1

# Restart Factorio service
echo "Restarting Factorio service..."
sudo systemctl start $SERVICE_NAME

# Cleanup
echo "Cleaning up..."
rm /tmp/factorio_headless.tar.xz

echo "Update complete. Factorio is now running with the latest version."
