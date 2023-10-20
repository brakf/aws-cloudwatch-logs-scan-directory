import os
import fnmatch
import json
import argparse

def generate_cw_config(config):
    try:
        directory = config['directory']
        patterns = config['patterns']
        log_group = config['log_group']
        log_stream_pattern = config['log_stream_pattern']
        
        # Check if the directory exists
        if not os.path.exists(directory):
            print(f"Error: The directory '{directory}' does not exist.")
            return
        
        config_entries = []
        
        for root, dirnames, filenames in os.walk(directory):
            for pattern in patterns:
                for filename in fnmatch.filter(filenames, pattern):
                    filepath = os.path.join(root, filename)
                    entry = {
                        "file_path": filepath,
                        "log_group_name": log_group,
                        "log_stream_name": f"{log_stream_pattern}/{filename}"
                    }
                    config_entries.append(entry)
                    
        cw_config_content = {
            "logs": {
                "logs_collected": {
                    "files": {
                        "collect_list": config_entries
                    }
                }
            }
        }
        
        with open("cloudwatch_config.json", "w") as file:
            json.dump(cw_config_content, file, indent=4)
            
    except KeyError as e:
        print(f"Error: Missing necessary configuration key: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate CloudWatch Unified Agent config.')
    
    parser.add_argument('--config', type=str, default='config.json', help='Path to the configuration file.')
    
    args = parser.parse_args()
    
    # Load configurations from file
    try:
        with open(args.config, 'r') as file:
            config = json.load(file)
        generate_cw_config(config)
    except FileNotFoundError:
        print(f"Error: Configuration file '{args.config}' not found.")
    except json.JSONDecodeError:
        print(f"Error: Failed to decode JSON in configuration file '{args.config}'.")
