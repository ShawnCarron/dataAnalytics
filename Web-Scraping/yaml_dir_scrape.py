import os
import yaml

def directory_to_yaml(directory):
    folder_structure = {}
   
    # Walk through all directories and files
    for root, dirs, files in os.walk(directory):
        folder = os.path.relpath(root, directory)
        print(f"Processing: {folder}")  # Tracks directory recursion
        folder_structure[folder] = [
            os.path.join(root, file).replace("\\", "/") for file in files

        ]  # Creates full file paths

    # Save as YAML file
    with open("contracts_map.yaml", "w") as file:
        yaml.dump({"contracts": folder_structure}, file, default_flow_style=False)

# Path to the directory containing your contracts
directory_path = r"path_to_dir"
directory_to_yaml(directory_path)