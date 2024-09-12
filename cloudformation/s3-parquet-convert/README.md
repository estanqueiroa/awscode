######################################
# Parquet to CSV Converter
######################################

This CloudFormation template creates an AWS S3 bucket and a Lambda function that converts a Parquet file stored in the bucket to a CSV file.

![Alt text](../diagrams/s3-parquet.png?raw=true "Diagram Image")

# Overview

The template includes the following resources:

- S3 Bucket: An S3 bucket is created with versioning enabled.
- Lambda Function: A Lambda function is created with the following properties:
- Runtime: Python 3.11
- Architecture: arm64
- Role: An IAM role with the necessary permissions to access the S3 bucket and write the converted CSV file back to the bucket
- Timeout: 30 seconds
- Memory Size: Configurable through the pMemorySize parameter
- Environment Variables: S3_BUCKET_NAME and S3_FILE_KEY are set to the names of the S3 bucket and the Parquet file key, respectively.
- Layers: The template includes the AWS SDK Pandas layer for Python 3.11 (arm64 architecture).

The Lambda function downloads the Parquet file from the S3 bucket, analyzes its properties, and converts it to a CSV file. The CSV file is then uploaded back to the S3 bucket.

# Parameters

The template includes the following parameters:

- pMemorySize: Allows you to adjust the memory size of the Lambda function to optimize processing time for large Parquet files.
- pTimeout: Configure Lambda function timeout according your parquet file size.

# Deployment

You can use [RAIN](https://github.com/aws-cloudformation/rain) to deploy the Cloudformation stack using the provided template:

```bash
s3-parquet-convert$ rain deploy s3-parquet-convert.yaml --tags valor1=titanic -y
```

If you create the target resource and related permissions in the same template, you might have a circular dependency.
To avoid this dependency, you can create all resources without specifying the Bucket Notification Configuration (comment the block below in the first deployment). 

```json
   NotificationConfiguration:
      LambdaConfigurations:
         - Event: s3:ObjectCreated:*
         Filter:
            S3Key:
               Rules:
               - Name: suffix
                  Value: '.parquet'
         Function: !GetAtt rConvertParquetLambdaFunction.Arn
```
After stack is created, uncomment the block in the template and update the stack, this will create the bucket notification configuration.

You can use same RAIN command to update the stack, it will create the change set and apply to existing stack:

```bash
s3-parquet-convert$ rain deploy s3-parquet-convert.yaml --tags valor1=titanic -y
```

# Testing the Solution

To test the solution after deployment, follow these steps:

1. Upload the 'titanic.parquet' file to the S3 bucket created by the CloudFormation template. This event will trigger the Lambda function to convert the file.
2. Check the CloudWatch logs for the Lambda function:
   - The logs should show the analysis of the Parquet file properties, such as the number of rows, columns, and the compression method used.
   - The logs should also show the conversion of the Parquet file to a CSV file and the upload of the CSV file to the S3 bucket.
3. Verify that the 'titanic.csv' file is present in the S3 bucket.

By following these steps, you can test the solution and ensure that the Parquet to CSV conversion is working as expected.