# tecRacer CloudWatch Logs Scan Directory

## Background

AWS CloudWatch Agent doesn't allow specifying directories for Log Extraction. A seperate configuration is needed per file.

## Description

This tool automatically scans specified directories and creates CloudWatch log streams for each file matching defined patterns. It is managed as a systemd service that ensures it runs automatically whenever the CloudWatch Agent is started.

## Installation

1. **Modify the config file according to your needs**

2. **Run the installation script with root privileges:**
   ```bash
   sudo ./install.sh
   ```
3. **Restart CloudWatch Agent. The script should automatically start**
   ```bash
   sudo  systemctl restart amazon-cloudwatch-agent.service
   ```

4. **Verify that the service ran successfully and the CloudWatch Agent is back up:**
   ```bash
   systemctl status amazon-cloudwatch-agent.service
   systemctl status cloudwatch-agent-scan-directory.service
   ```

5. **Verify the Config File was created**

   cat /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.d/directory_scan.json

## Usage

- The service runs once in the background whenever the CloudWatch Agent is started.
- Configuration parameters, such as directory paths and patterns, can be adjusted in the `config.json` file located in the installation directory (`/opt/tecRacer/cloudwatch-agent-scan-directory`).

## Uninstallation

1. **Navigate to the directory containing the uninstallation script:**
   ```bash
   cd <your-repository-directory>
   ```

2. **Run the uninstallation script with root privileges:**
   ```bash
   sudo ./uninstall.sh
   ```

4. **Verify that the service and files are removed:**
   - Check that the service is no longer listed in the systemd services.
   - Confirm the removal of the application directory and its contents.


## How Log Rotation is handled

The current version of the tool will add an asterisk behind the log name OR at the location of the first "."
This is to properly handle log rotation as described here: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Agent-Configuration-File-Details.html#CloudWatch-Agent-Configuration-File-Logssection

