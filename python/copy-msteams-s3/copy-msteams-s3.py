# script to copy files from Microsoft Teams to an AWS S3 bucket using the Microsoft Graph API and AWS Boto3

import os
from O365 import Account
import boto3
from botocore.exceptions import NoCredentialsError

def copy_teams_to_s3(client_id, client_secret, s3_bucket, teams_folder_path):
    # Initialize Microsoft Graph API connection
    credentials = (client_id, client_secret)
    account = Account(credentials)
    account.authenticate()

    # Initialize S3 client
    s3_client = boto3.client('s3')

    # Get SharePoint/Teams files
    storage = account.storage()
    drive = storage.get_default_drive()
    
    # Get the specified folder
    folder = drive.get_item_by_path(teams_folder_path)
    items = folder.get_items()

    # Upload each file to S3
    for item in items:
        if not item.is_folder:
            try:
                # Download file from Teams
                local_file = item.download()
                file_name = item.name

                # Upload to S3
                s3_client.upload_file(
                    local_file,
                    s3_bucket,
                    file_name
                )
                print(f"Successfully uploaded {file_name} to S3")

                # Clean up local file
                os.remove(local_file)

            except NoCredentialsError:
                print("AWS credentials not found")
            except Exception as e:
                print(f"Error uploading {file_name}: {str(e)}")

# Usage example
if __name__ == "__main__":
    CLIENT_ID = "your_microsoft_client_id"
    CLIENT_SECRET = "your_microsoft_client_secret"
    S3_BUCKET = "your-s3-bucket-name"
    TEAMS_FOLDER_PATH = "/General/your-folder-path"

    copy_teams_to_s3(CLIENT_ID, CLIENT_SECRET, S3_BUCKET, TEAMS_FOLDER_PATH)
