#!/bin/bash

# Variables
APP_DIRECTORY="/opt/tecRacer/cloudwatch-agent-scan-directory"
PYTHON_SCRIPT="cloudwatch-agent-scan-directory.py"
CONFIG_FILE="config.json"
SERVICE_FILE="cloudwatch-agent-scan-directory.service"

# Creating application directory
mkdir -p "$APP_DIRECTORY"

# Copying the Python script and configuration file
cp "$PYTHON_SCRIPT" "$CONFIG_FILE" "$APP_DIRECTORY"

# Creating the systemd service file
echo "[Unit]
Description=tecRacer CloudWatch Logs Scan Directory
Before=amazon-cloudwatch-agent.service

[Service]
Type=simple
ExecStart=/usr/bin/python3 $APP_DIRECTORY/$PYTHON_SCRIPT --config $APP_DIRECTORY/$CONFIG_FILE
Restart=on-failure

[Install]
WantedBy=default.target" > "$SERVICE_FILE"

# Moving the service file to the systemd directory
mv "$SERVICE_FILE" "/etc/systemd/system/"

# Reloading systemd to recognize the new service
systemctl daemon-reload

# Enabling the service to start on boot
systemctl enable "$SERVICE_FILE"

# Printing success message
echo "tecRacer CloudWatch Logs Scan Directory has been installed and configured successfully!"
