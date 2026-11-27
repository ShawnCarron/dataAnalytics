import yaml
from xml.etree.ElementTree import Element, SubElement, ElementTree

def yaml_to_xml(yaml_file, xml_file):

    # Load YAML data
    with open(yaml_file, "r") as file:
        yaml_data = yaml.safe_load(file)

    # Create XML root element
    root_element = Element("contracts")

    # Convert YAML data to XML
    for folder, files in yaml_data.get("contracts", {}).items():
        folder_element = SubElement(root_element, "folder", name=folder)
        for file_name in files:
            SubElement(folder_element, "file", name=file_name)

    # Save XML file
    tree = ElementTree(root_element)

    with open(xml_file, "wb") as file:

        tree.write(file)

    # Convert the YAML file to XML
yaml_to_xml("contracts_map.yaml", "contracts_map.xml")