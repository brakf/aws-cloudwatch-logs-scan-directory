# tecRacer CloudWatch Logs Scan Directory

## Description

This tool automatically scans specified directories and creates CloudWatch log streams for each file matching defined patterns. It is managed as a systemd service that ensures it’s running continuously, restarting on failure, and starting during system boots.

## Installation

1. **Clone the repository or download the source code:**
   ```bash
   git clone <your-repository-url>
   ```

2. **Navigate to the directory containing the installation script:**
   ```bash
   cd <your-repository-directory>
   ```

3. **Make the installation script executable:**
   ```bash
   chmod +x install_my_app.sh
   ```

4. **Run the installation script with root privileges:**
   ```bash
   sudo ./install_my_app.sh
   ```

5. **Verify that the service is running:**
   ```bash
   systemctl status cloudwatch-agent-scan-directory.service
   ```

## Usage

- The service should run in the background automatically once installed.
- Configuration parameters, such as directory paths and patterns, can be adjusted in the `config.json` file located in the installation directory (`/opt/tecRacer/cloudwatch-agent-scan-directory`).

## Uninstallation

1. **Navigate to the directory containing the uninstallation script:**
   ```bash
   cd <your-repository-directory>
   ```

2. **Make the uninstallation script executable:**
   ```bash
   chmod +x uninstall_cloudwatch_agent_scan_directory.sh
   ```

3. **Run the uninstallation script with root privileges:**
   ```bash
   sudo ./uninstall_cloudwatch_agent_scan_directory.sh
   ```

4. **Verify that the service and files are removed:**
   - Check that the service is no longer listed in the systemd services.
   - Confirm the removal of the application directory and its contents.

## Support

- For bugs, feature requests, or general queries, please open an issue in the project repository.

## License

- This project is licensed under the MIT License.