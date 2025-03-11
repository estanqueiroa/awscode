# Python script to copy files from Microsoft Teams to an AWS S3 bucket using the Microsoft Graph API and AWS Boto3

## Requirements

Before running this script, make sure to:

* Install required packages:
    
`pip install O365 boto3`
    
Set up prerequisites:

* Register an Azure AD application to get CLIENT_ID and CLIENT_SECRET
* Configure AWS credentials (either through AWS CLI or environment variables)
* Create an S3 bucket
* Have necessary permissions for both Microsoft Teams and AWS S3

Replace the following variables in the script:

* CLIENT_ID: Your Microsoft Azure AD application ID
* CLIENT_SECRET: Your Microsoft Azure AD application secret
* S3_BUCKET: Your S3 bucket name
* TEAMS_FOLDER_PATH: The path to your Teams folder

## Deployment

The script will:

* Connect to Microsoft Teams using Graph API
* Access the specified folder
* Download each file
* Upload it to the specified S3 bucket
* Remove the local copy
* Handle errors appropriately

## Notes

Note: This is a basic implementation. You might want to add:

* File type filtering
* Subfolder handling
* Progress tracking for large files
* Retry logic for failed transfers
* Concurrent uploads for better performance