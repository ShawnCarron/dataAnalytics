import xml.etree.ElementTree as ET
import csv
import os

# Get user input for file paths
xml_file_path = r"C:\Users\shawn\OneDrive\Documents\dataScience\contracts_map.xml"
csv_file_path = r"C:\Users\shawn\OneDrive\Documents\dataScience\output.csv"

def xml_to_csv(xml_file, csv_file):
    # Check if XML file exists
    if not os.path.isfile(xml_file):
        print(f"Error: The file '{xml_file}' does not exist.")
        return

    # Parse the XML file
    tree = ET.parse(xml_file)
    root = tree.getroot()

    # Open CSV file for writing
    with open(csv_file, 'w', newline='') as csvfile:
        csvwriter = csv.writer(csvfile)

        # Write the header
        csvwriter.writerow(['folder', 'file'])

        # Extract data from XML and write to CSV
        for folder in root.findall('folder'):
            folder_name = folder.get('name')
            for file in folder.findall('file'):
                file_name = file.get('name')
                csvwriter.writerow([folder_name, file_name])

# Convert XML to CSV
xml_to_csv(xml_file_path, csv_file_path)
