# Download AWS Lambda function code as a ZIP file

# To use this code:

# Make sure you have both boto3 and requests libraries installed (pip install boto3 requests)
# Configure your AWS credentials properly
# Replace 'my-function-name' with your actual Lambda function name
# Replace 'function.zip' with your desired output path

# The script will:

# Connect to AWS Lambda
# Get a presigned URL for the function code
# Download the code
# Save it as a ZIP file locally

import boto3
import requests

def download_lambda_code(function_name, output_path):
    # Create Lambda client
    lambda_client = boto3.client('lambda')
    
    # Get Lambda function code
    response = lambda_client.get_function(FunctionName=function_name)
    code_url = response['Code']['Location']
    
    # Download code from presigned URL
    code_zip = requests.get(code_url)
    
    # Save to local ZIP file
    with open(output_path, 'wb') as f:
        f.write(code_zip.content)
    
    print(f"Lambda code downloaded to {output_path}")

# Example usage
download_lambda_code('your-function-name', 'lambda-code.zip')