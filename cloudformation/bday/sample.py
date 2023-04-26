#importing packages
import json
import boto3
import os

#function definition
def lambda_handler(event,context):

    dynamodb = boto3.resource('dynamodb')
    #table name
    Target=os.environ["DB_TABLE"]
    table = dynamodb.Table(Target)
    #inserting values into table
    response = table.put_item(
        Item={
            'Name': 'Test',
            'BDate': '2023-02-23'
            
        }
    )
    return response