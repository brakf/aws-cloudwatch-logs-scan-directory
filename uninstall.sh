#!/bin/bash

# Variables
APP_DIRECTORY="/opt/tecRacer/cloudwatch-agent-scan-directory"
SERVICE_NAME="cloudwatch-agent-scan-directory"
SERVICE_FILE="$SERVICE_NAME.service"
OVERRIDE_DIR="/etc/systemd/system/amazon-cloudwatch-agent.service.d"
OVERRIDE_FILE="override.conf"

# Stopping the service if it is running
systemctl stop "$SERVICE_NAME"

# Disabling the service to not start on boot
systemctl disable "$SERVICE_NAME"

# Removing the systemd service file
rm "/etc/systemd/system/$SERVICE_FILE"

# Removing the override file for the CloudWatch agent
rm "$OVERRIDE_DIR/$OVERRIDE_FILE"

# If the override directory is empty, it might be a good idea to remove it as well
rmdir --ignore-fail-on-non-empty "$OVERRIDE_DIR"

# Reloading systemd to recognize the service removal
systemctl daemon-reload
systemctl reset-failed

# Restarting the CloudWatch agent to apply the changes
systemctl restart amazon-cloudwatch-agent.service

# Removing the application directory and its content
rm -rf "$APP_DIRECTORY"

# Printing success message
echo "tecRacer CloudWatch Logs Scan Directory has been uninstalled successfully!"
