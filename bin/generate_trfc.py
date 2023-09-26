import os
import json

# Function to generate credentials.trfc.json
def generate_credentials(token):
    # Get the path to the user's home directory
    home_directory = os.path.expanduser("~")

    # Define the path to the .terraform directory and create it if it doesn't exist
    terraform_dir = os.path.join(home_directory, ".terraform")
    os.makedirs(terraform_dir, exist_ok=True)

    # Define the path to the credentials.trfc.json file within .terraform
    credentials_file = os.path.join(terraform_dir, "credentials.trfc.json")

    # Create a credentials dictionary
    trfc_credentials = { 
        'credentials' : {
            "token": token,
            "credentialsVersion": 1
            } 
        } 

    # Write the credentials to a JSON file
    with open(credentials_file, "w") as json_file:
        json.dump(trfc_credentials, json_file, indent=4)

    print(f"Credentials file ({credentials_file}) has been generated successfully.")

def main():
    # Read the Terraform Cloud token from the environmental variable
    token = os.environ.get("TERRAFORM_CLOUD_TOKEN")

    if not token:
        print("TERRAFORM_CLOUD_TOKEN environmental variable is not set.")
        exit(1)

    # Generate the credentials.trfc.json file
    generate_credentials(token)

if __name__ == "__main__":
    main()
