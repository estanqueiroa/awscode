# Serverless QR code generator

This template will set up an API Gateway, Lambda functions, DynamoDB table, and S3 bucket.

![Alt text](../diagrams/lambda-qrcode.png?raw=true "Diagram Image")

This CloudFormation template creates:

* An S3 bucket to store QR code images
* A DynamoDB table to store metadata
* A Lambda function that generates QR codes
* An API Gateway to expose the Lambda function
* Necessary IAM roles and permissions

[Reference here](https://towardsaws.com/building-a-serverless-qr-code-generator-with-aws-056b138c67da)

## Requirements

If you get this Error message:  "Runtime.ImportModuleError: Error: Cannot find module 'qrcode'" , please follow these steps:

* First, create a script to create the Lambda Layer (create-layer.sh):

```bash
#!/bin/bash

# Create layer directory structure
mkdir -p nodejs/node_modules

# Create package.json in the nodejs directory
cat > nodejs/package.json << EOF
{
  "name": "qrcode-layer",
  "version": "1.0.0",
  "dependencies": {
    "qrcode": "^1.5.3",
    "@aws-sdk/client-s3": "^3.0.0",
    "@aws-sdk/client-dynamodb": "^3.0.0",
    "@aws-sdk/lib-dynamodb": "^3.0.0"
  }
}
EOF

# Install dependencies
cd nodejs
npm install
cd ..

# Create ZIP file
zip -r qrcode-layer.zip nodejs

# Publish layer
LAYER_ARN=$(aws lambda publish-layer-version \
    --layer-name qrcode-layer \
    --description "Layer for QR Code generation with AWS SDK v3" \
    --license-info "MIT" \
    --zip-file fileb://qrcode-layer.zip \
    --compatible-runtimes nodejs16.x nodejs18.x \
    --query 'LayerVersionArn' \
    --output text)

echo "Layer ARN: $LAYER_ARN"

# Clean up
rm -rf nodejs qrcode-layer.zip
```

* Make the script executable and run it:

```bash
chmod +x create-layer.sh
./create-layer.sh
```

* Copy Layer ARN output to use as CloudFormation parameter.

## Deployment

* Deploy the CloudFormation template:

`aws cloudformation create-stack --stack-name qr-code-generator --template-body file://template.yaml --capabilities CAPABILITY_IAM`


* To check if the Lambda layer is correctly attached:

```bash   
aws lambda get-function-configuration \
    --function-name YOUR_LAMBDA_FUNCTION_NAME \
    --query 'Layers[*].Arn'
```

## Testing

* To generate a QR code, send a POST request to the API endpoint:

```bash
curl -X POST https://your-api-endpoint/prod/generate \
-H "Content-Type: application/json" \
-d '{"url": "https://example.com"}'
```
    
The API will return QR Code image filename generated in S3 bucket:

```bash
{
  "id": "1234567890",
  "url": "https://example.com",
  "qr_code_url": "https://bucket-name.s3.amazonaws.com/1234567890.png"
}
```

## Cleanup

* Verify S3 bucket is empty (delete all files if required)
* Delete CloudFormation stack to delete all resources

## Future Improvements

* Consider adding API key authentication or other security measures
* Add error handling and input validation as needed
* Consider adding CloudWatch logs and metrics for monitoring



