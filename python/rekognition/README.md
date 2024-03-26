## Simple demo of Amazon Rekognition

Amazon Rekognition is a cloud-based image and video analysis service that makes it easy to add advanced computer vision capabilities to your applications. The service is powered by proven deep learning technology and it requires no machine learning expertise to use. Amazon Rekognition includes a simple, easy-to-use API that can quickly analyze any image or video file that’s stored in Amazon S3 or local PC.

This simple demo shows the AWS Rekognition "DetectFace" method in action using Python code.

To run this demo, clone the Github repository to your local machine. It includes 1 demo picture (you can use your pictures if want).

## Requirements

* AWS account with IAM permission to enable and run AWS Rekognition service;
* Python 3.9 (or newer) installed.

## Testing

* Configure AWS credentials using profile or temporary token (STS).

* Create a local variable for image path files:

```bash
export IMAGE_PATH="blue-origin.jpg"
```

* Run the Python script:

```bash
python3 recognize.py
```

* If everything is OK, it should provide a similar output like below:

```bash
Face ID: None
Gender: Female
Age Range: {'Low': 75, 'High': 83}
Smile: True
Eyeglasses: False
Sunglasses: False
Beard: False
Mustache: False
Face Occluded: False
Emotions: HAPPY

Processing time for 4 faces detected: 1.43 seconds
```

## Troubleshooting

Error #1: "botocore.exceptions.ClientError: An error occurred (ExpiredTokenException) when calling the DetectFaces operation: The security token included in the request is expired or not valid"

Resolution: Verify your are providing valid AWS credentials.

Error #2: "KeyError: 'IMAGE_PATH'"

Resolution: Verify you have create the OS variable IMAGE_PATH.

```bash
export IMAGE_PATH="blue-origin.jpg"
```

Error #3: "FileNotFoundError: [Errno 2] No such file or directory: 'blue-origin2.jpg'"

Rsolution: Verify you have specified a valid filename in the IMAGE_PATH variable.

## References

https://docs.aws.amazon.com/rekognition/latest/dg/faces-detect-images.html

