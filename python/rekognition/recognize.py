# Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
# PDX-License-Identifier: MIT-0 (For details, see https://github.com/awsdocs/amazon-rekognition-developer-guide/blob/master/LICENSE-SAMPLECODE.)
#
# https://docs.aws.amazon.com/rekognition/latest/dg/faces.html
#
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rekognition/client/detect_faces.html

import boto3
import os
import time

start = time.time()

# number of faces detected
counter = 0


def recognize_faces_in_picture(image_path):
    # Initialize AWS Rekognition client
    client = boto3.client('rekognition', region_name ='us-east-1')

    # Read image bytes from file
    with open(image_path, 'rb') as image_file:
        image_bytes = image_file.read()

    # Call AWS Rekognition's detect_faces method
    response = client.detect_faces(
        Image={
            'Bytes': image_bytes
        },
        Attributes=['ALL']
    )

    # Extract face details from response
    face_details = response.get('FaceDetails', [])

    # Print details of recognized faces
    for face in face_details:
        print("Face ID:", face.get('FaceId'))
        print("Gender:", face.get('Gender').get('Value'))
        print("Age Range:", face.get('AgeRange'))
        print("Smile:", face.get('Smile').get('Value'))
        print("Eyeglasses:", face.get('Eyeglasses').get('Value'))
        print("Sunglasses:", face.get('Sunglasses').get('Value'))
        print("Beard:", face.get('Beard').get('Value'))
        print("Mustache:", face.get('Mustache').get('Value'))
        print("Face Occluded:", face.get('FaceOccluded').get('Value'))
        # print("Emotions:", [emotion.get('Type') for emotion in face.get('Emotions')]) # print list of emotions
        print("Emotions:", face['Emotions'][0].get('Type')) # print most likely emotion
        print()

        global counter
        counter +=1
        
    return face_details

# time processing
end = time.time()
processing = (end - start) * 10e5 # convert to seconds

# Example usage

# First, create OS variable to process your local image e.g. export IMAGE_PATH="sample_image.jpeg"

image_path = os.environ['IMAGE_PATH']
face_details = recognize_faces_in_picture(image_path)
print(f'Processing time for {counter} faces detected: {processing:.3} seconds')
