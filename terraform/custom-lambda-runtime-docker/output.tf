# ECR login command output
output "ecr_login_command" {
  value = "aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${aws_ecr_repository.lambda_ecr_repo.repository_url}"
}

# Output Lambda function details
output "lambda_function_name" {
  value = aws_lambda_function.lambda_docker.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.lambda_docker.arn
}

output "lambda_function_url" {
  value = aws_lambda_function_url.lambda_url.function_url
}