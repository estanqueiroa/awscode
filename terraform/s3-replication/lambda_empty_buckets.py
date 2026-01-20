import boto3
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    source_bucket = os.environ['SOURCE_BUCKET']
    replica_bucket = os.environ['REPLICA_BUCKET']
    
    buckets = [source_bucket, replica_bucket]
    
    for bucket in buckets:
        try:
            # Delete all object versions
            paginator = s3.get_paginator('list_object_versions')
            for page in paginator.paginate(Bucket=bucket):
                objects = []
                
                # Delete versions
                if 'Versions' in page:
                    objects.extend([{'Key': obj['Key'], 'VersionId': obj['VersionId']} 
                                   for obj in page['Versions']])
                
                # Delete delete markers
                if 'DeleteMarkers' in page:
                    objects.extend([{'Key': obj['Key'], 'VersionId': obj['VersionId']} 
                                   for obj in page['DeleteMarkers']])
                
                if objects:
                    s3.delete_objects(Bucket=bucket, Delete={'Objects': objects})
            
            print(f"Emptied bucket: {bucket}")
        
        except Exception as e:
            print(f"Error emptying {bucket}: {str(e)}")
            raise
    
    return {'statusCode': 200, 'body': 'Buckets emptied successfully'}
