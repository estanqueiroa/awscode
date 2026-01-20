output "source_bucket_name" {
  description = "Name of the source S3 bucket"
  value       = aws_s3_bucket.source.id
}

output "replica_bucket_name" {
  description = "Name of the replica S3 bucket"
  value       = aws_s3_bucket.replica.id
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function to empty buckets"
  value       = aws_lambda_function.empty_buckets.arn
}
