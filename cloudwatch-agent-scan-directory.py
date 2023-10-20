import os
import fnmatch
import json
import argparse

def generate_cw_config(config):
    try:
        directory = config['directory']
        patterns = config['patterns']
        log_group = config['log_group']
        cloudwatch_config_file = config['cloudwatch_config_file']
        log_stream_pattern = config['log_stream_pattern']
        
        # Check if the directory exists
        if not os.path.exists(directory):
            print(f"Error: The directory '{directory}' does not exist.")
            return
        
        config_entries = []
        seen_files = set()  # Set to keep track of unique filenames
        
        for root, dirnames, filenames in os.walk(directory):
            for pattern in patterns:
                for filename in fnmatch.filter(filenames, pattern):
                    short_filename = filename.split('.', 1)[0]  # Get the filename without the extension
                    modified_filename = short_filename + "*"  # Modify filename
                    if modified_filename not in seen_files:  # Check for uniqueness
                        filepath = os.path.join(root, filename)
                        modified_filepath = os.path.join(root, modified_filename)  # Modify filepath
                        entry = {
                            "file_path": modified_filepath,
                            "log_group_name": log_group,
                            "log_stream_name": f"{log_stream_pattern}/{short_filename}"
                        }
                        config_entries.append(entry)
                        seen_files.add(modified_filename)  # Add the modified filename to the set

                    
        cw_config_content = {
            "logs": {
                "logs_collected": {
                    "files": {
                        "collect_list": config_entries
                    }
                }
            }
        }
        
        with open(cloudwatch_config_file, "w") as file:
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

