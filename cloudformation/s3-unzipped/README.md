# S3 Bucket with Lambda Trigger to Process Uploaded Zip Files

This CloudFormation template creates the following resources:

* S3 Bucket: An S3 bucket with versioning enabled.
* Lambda Role: An IAM role with the AWSLambdaBasicExecutionRole managed policy attached, which grants the necessary permissions for the Lambda function to write logs.
* Lambda Function: The Lambda function that will be triggered when a file is uploaded to the S3 bucket. The function checks if the uploaded file is a zip file, downloads the file, extracts its contents, and uploads the extracted files back to the S3 bucket.
* S3 Trigger: A Lambda permission that allows the S3 service to invoke the Lambda function.
* S3 Bucket Trigger: An S3 bucket notification configuration that triggers the Lambda function whenever a new object is created (uploaded) with a .zip extension.

![Alt text](../diagrams/zipfiles.png?raw=true "Diagram Image")

Based on this [post](https://medium.com/@darrenroback/how-to-process-and-extract-zip-files-with-aws-lambda-ed2a59f6b746)

## Deployment

To deploy this template, you can use the AWS CloudFormation console, AWS CLI, or AWS SDK.

* AWS CloudFormation Console

- Log in to the AWS Management Console and navigate to the CloudFormation service.
- Click "Create stack" and choose "With new resources (standard)".
- Select "Upload a template file" and choose the YAML file containing the CloudFormation template.
- Fill in the required parameters, such as the bucket name, and click "Next" through the remaining steps.
- Review the stack details and create the stack.

* AWS CLI

Save the CloudFormation template to a YAML file (e.g., s3-bucket-with-lambda-trigger.yaml).

Run the following command to create the stack:

`aws cloudformation create-stack --stack-name my-s3-bucket-with-lambda --template-body file://s3-bucket-with-lambda-trigger.yaml --parameters ParameterKey=BucketName,ParameterValue=my-s3-bucket`

Replace my-s3-bucket-with-lambda with the desired stack name and my-s3-bucket with the desired bucket name.


## Usage

After the stack is created, you can upload zip files to root folder of the S3 bucket, and the Lambda function will automatically extract the contents of the zip file and upload the extracted files to the same S3 bucket in the /unzipped/ folder.

## Troubleshooting

Error message: Resource handler returned message: "Unable to validate the following destination configurations (Service: S3, Status Code: 400, Request ID

This is a known issue documented in AWS S3 Cloudformation [documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket-notificationconfiguration.html)

To avoid this dependency, you can create all resources without specifying the notification configuration. Then, update the stack with a notification configuration.

Uncomment the code block below and deploy Template again to update the Stack:

```bash
  S3Bucket:
    Type: AWS::S3::Bucket
    Properties:
      VersioningConfiguration:
        Status: Enabled
      # NotificationConfiguration:
      #   LambdaConfigurations:
      #     - Event: s3:ObjectCreated:*
      #       Function: !GetAtt LambdaFunction.Arn
      #       Filter:
      #         S3Key:
      #           Rules:
      #             - Name: suffix
      #               Value: .zip
```