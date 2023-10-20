#!/bin/bash

# Variables
APP_DIRECTORY="/opt/tecRacer/cloudwatch-agent-scan-directory"
SERVICE_FILE="cloudwatch-agent-scan-directory.service"

# Stopping the service if it is running
systemctl stop "$SERVICE_FILE"

# Disabling the service to not start on boot
systemctl disable "$SERVICE_FILE"

# Removing the systemd service file
rm "/etc/systemd/system/$SERVICE_FILE"

# Reloading systemd to recognize the service removal
systemctl daemon-reload
systemctl reset-failed

# Removing the application directory and its content
rm -rf "$APP_DIRECTORY"

# Printing success message
echo "tecRacer CloudWatch Logs Scan Directory has been uninstalled successfully!"
