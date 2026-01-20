
resource "aws_lambda_function" "empty_buckets" {
  #checkov:skip=CKV_AWS_50:X-Ray tracing not required for this function
  #checkov:skip=CKV_AWS_117:VPC not required for S3 access
  #checkov:skip=CKV_AWS_116:DLQ not required for manual invocation
  #checkov:skip=CKV_AWS_173:Environment variables contain bucket names only
  #checkov:skip=CKV_AWS_272:Code signing not required for this use case
  
  filename         = data.archive_file.lambda.output_path
  function_name    = "empty-s3-buckets"
  role             = aws_iam_role.lambda.arn
  handler          = "lambda_empty_buckets.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "python3.12"
  timeout          = 300
  architectures    = ["arm64"]
  reserved_concurrent_executions = 1

  environment {
    variables = {
      SOURCE_BUCKET  = aws_s3_bucket.source.id
      REPLICA_BUCKET = aws_s3_bucket.replica.id
    }
  }
}
