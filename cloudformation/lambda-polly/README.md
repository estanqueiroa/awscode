# Lambda function to convert text to audio file using Polly service (text to speech)

It creates a Lambda function to read a text file from an S3 bucket and convert it to audio using Amazon Polly.

![Alt text](../diagrams/lambda-polly.png?raw=true "Diagram Image")

* Converts .txt files to audio .mp3 files.

## Deployment

Create S3 bucket for input / output with public access blocked (recommended) using AWS CLI (you can use same bucket for both or use existing ones):

```bash
aws s3api create-bucket \
    --bucket my-bucket-name \
    --region us-east-1 \
    --block-public-access-configuration '{"BlockPublicAcls": true, "IgnorePublicAcls": true, "BlockPublicPolicy": true, "RestrictPublicBuckets": true}'
```

Create the stack using AWS CLI or CloudFormation console:

```bash
aws cloudformation create-stack \
    --stack-name TextToSpeechStack \
    --template-body file://text-to-speech-lambda.yaml \
    --parameters ParameterKey=InputBucket,ParameterValue=your-input-bucket-name \
                 ParameterKey=OutputBucket,ParameterValue=your-output-bucket-name \
    --capabilities CAPABILITY_IAM
```
    

**Note**: Ensure both input and output S3 buckets exist before creating the stack.

## Testing

* Upload a .txt file to S3 bucket and verify the corresponding .mp3 audio file is generated sucessfully in the output bucket.

## Cleanup

* Delete CloudFormation stack to remove all created resources.

## Future Releases

* Update Lambda code to use other Polly engines / voices such as this (Neural voices example (higher quality)):

```bash 
aws polly synthesize-speech \
    --engine neural \
    --voice-id Matthew \
    --text "This is neural TTS" \
    --output-format mp3 \
    output.mp3
```