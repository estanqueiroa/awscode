# python to read dynamodb record and compare to today date  

import os
import boto3
import datetime

# read dynamo db


def read():
    dynamodb = boto3.resource('dynamodb')
    Target=os.environ["DB_TABLE"]
    table = dynamodb.Table(Target)
    items = table.scan()['Items']

  #  read date from system
    today = datetime.date.today()
    print("Hoje: " + str(today))

    for item in items:
        print (item)

        if str(today) == item['BDate']:

            print("same")   
            
        else:   
            print("not same")


read()


    



