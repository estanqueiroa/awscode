# script to list only the services that have been accessed (i.e., have a last accessed date) for the specified IAM role

import boto3
from botocore.exceptions import ClientError
import time
from datetime import datetime, timezone

# Specify your AWS region
AWS_REGION = "us-east-1"  # Replace with your preferred region

def validate_iam_role(role_name):
    iam = boto3.client('iam', region_name=AWS_REGION)
    try:
        role = iam.get_role(RoleName=role_name)
        return role['Role']['Arn']
    except ClientError as e:
        if e.response['Error']['Code'] == 'NoSuchEntity':
            return None
        else:
            raise

def get_last_accessed_details(role_arn):
    iam = boto3.client('iam', region_name=AWS_REGION)
    try:
        response = iam.generate_service_last_accessed_details(Arn=role_arn)
        job_id = response['JobId']
        
        while True:
            result = iam.get_service_last_accessed_details(JobId=job_id)
            if result['JobStatus'] == 'COMPLETED':
                return result['ServicesLastAccessed']
            elif result['JobStatus'] in ['FAILED', 'IN_PROGRESS']:
                print(f"Job status: {result['JobStatus']}. Waiting...")
                time.sleep(2)  # Wait for 2 seconds before checking again
            else:
                print(f"Unexpected job status: {result['JobStatus']}")
                return None

    except ClientError as e:
        print(f"Error getting last accessed details: {e}")
        return None

def print_last_accessed_info(role_name, last_accessed_details):
    print(f"\nLast Accessed Information for IAM Role: {role_name}")
    print("-" * 50)
    
    if last_accessed_details:
        accessed_services = [service for service in last_accessed_details if service.get('LastAuthenticated')]
        
        if accessed_services:
            # Sort services by last accessed date, most recent first
            accessed_services.sort(key=lambda x: x['LastAuthenticated'], reverse=True)
            
            for service in accessed_services:
                service_name = service['ServiceName']
                last_accessed = service['LastAuthenticated'].replace(tzinfo=timezone.utc).astimezone(tz=None)
                last_accessed_str = last_accessed.strftime('%Y-%m-%d %H:%M:%S %Z')
                last_authenticated_entity = service.get('LastAuthenticatedEntity', 'N/A')
                
                print(f"Service: {service_name}")
                print(f"  Last accessed: {last_accessed_str}")
                print(f"  Last authenticated entity: {last_authenticated_entity}")
                print(f"  Service namespace: {service.get('ServiceNamespace', 'N/A')}")
                print(f"  Total authenticated entities: {service.get('TotalAuthenticatedEntities', 0)}")
                print("-" * 30)
            
            print(f"\nTotal services accessed: {len(accessed_services)}")
        else:
            print("No services have been accessed by this role.")
    else:
        print("No last accessed information available.")

def main():
    role_name = input("Enter the IAM role name: ")
    role_arn = validate_iam_role(role_name)
    
    if role_arn:
        print(f"Fetching last accessed information for role: {role_name}")
        last_accessed_details = get_last_accessed_details(role_arn)
        print_last_accessed_info(role_name, last_accessed_details)
    else:
        print(f"Error: IAM role '{role_name}' does not exist.")

if __name__ == "__main__":
    main()
