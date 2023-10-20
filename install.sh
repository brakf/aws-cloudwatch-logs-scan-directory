#!/bin/bash

# Variables
APP_DIRECTORY="/opt/tecRacer/cloudwatch-agent-scan-directory"
PYTHON_SCRIPT="cloudwatch-agent-scan-directory.py"
CONFIG_FILE="config.json"
SERVICE_NAME="cloudwatch-agent-scan-directory"
SERVICE_FILE="$SERVICE_NAME.service"
OVERRIDE_DIR="/etc/systemd/system/amazon-cloudwatch-agent.service.d"
OVERRIDE_FILE="override.conf"

# Creating application directory
mkdir -p "$APP_DIRECTORY"

# Copying the Python script and configuration file
cp "$PYTHON_SCRIPT" "$CONFIG_FILE" "$APP_DIRECTORY"

# Creating the systemd service file
echo "[Unit]
Description=tecRacer CloudWatch Logs Scan Directory

[Service]
Type=oneshot
ExecStart=/usr/bin/python3 $APP_DIRECTORY/$PYTHON_SCRIPT --config $APP_DIRECTORY/$CONFIG_FILE
Restart=no

[Install]
WantedBy=default.target" > "$SERVICE_FILE"

# Moving the service file to the systemd directory
mv "$SERVICE_FILE" "/etc/systemd/system/"

# Creating directory for the override file if it doesn’t exist
mkdir -p "$OVERRIDE_DIR"

# Creating the override file to start your service before the CloudWatch agent
echo "[Service]
ExecStartPre=/bin/systemctl start $SERVICE_NAME" > "$OVERRIDE_DIR/$OVERRIDE_FILE"

# Reloading systemd to recognize the new service and override
systemctl daemon-reload

# Enabling the service to start on boot
systemctl enable "$SERVICE_FILE"

# Starting the service immediately
systemctl start "$SERVICE_NAME"

# Printing success message
echo "tecRacer CloudWatch Logs Scan Directory has been installed and configured successfully!"
