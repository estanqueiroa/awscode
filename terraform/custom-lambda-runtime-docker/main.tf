# Get current AWS region
data "aws_region" "current" {}

# Step 1: Create an ECR repository
resource "aws_ecr_repository" "lambda_ecr_repo" {
  name                 = "lambda-docker-repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  repository = aws_ecr_repository.lambda_ecr_repo.name

  policy     = <<EOF
{
    "rules": [
        {
          "rulePriority": 1,
          "description": "Expire tagged images and maintain last 10 latest images",
          "selection": {
              "tagStatus": "any",
              "countType": "imageCountMoreThan",
              "countNumber": 10
          },
          "action": {
              "type": "expire"
          }
      }
    ]
}
EOF
  depends_on = [aws_ecr_repository.lambda_ecr_repo]
}

resource "aws_ecr_repository_policy" "policy" {

  repository = aws_ecr_repository.lambda_ecr_repo.name

  policy     = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowCrossAccountPull",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "*"
        ]
      },
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ]
    }
    
  ]
}
EOF
  depends_on = [aws_ecr_repository.lambda_ecr_repo]

}

# Build and push Docker image using null_resource
resource "null_resource" "build_push_docker_images" {
  provisioner "local-exec" {
    command = <<EOT
      # Log in to ECR
      aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${aws_ecr_repository.lambda_ecr_repo.repository_url}
      # Build Docker image
      # docker build -t lambda-docker-demo ./application/.
      docker buildx build --platform linux/amd64 -t lambda-docker-demo ./application/.
      # Tag Docker image
      docker tag lambda-docker-demo:latest ${aws_ecr_repository.lambda_ecr_repo.repository_url}:latest
      # Push Docker image to ECR
      docker push ${aws_ecr_repository.lambda_ecr_repo.repository_url}:latest
    EOT
  }

  triggers = {
    ecr_url = aws_ecr_repository.lambda_ecr_repo.repository_url
  }
}

# Step 2: Lambda execution role
resource "aws_iam_role" "lambda_exec_role" {
  name = "docker_lambda_exec_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow"
      }
    ]
  })
}

# Attach necessary policies to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_exec_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Introduce a delay (e.g., 60 seconds)
resource "time_sleep" "wait_for_deployment" {
  depends_on      = [null_resource.build_push_docker_images] # Wait after IAM role creation
  create_duration = "60s"                                    # Set delay duration
}

# Step 3: Create the Lambda function using Docker image
resource "aws_lambda_function" "lambda_docker" {
  function_name = "lambda-docker-demo"
  role          = aws_iam_role.lambda_exec_role.arn

  package_type = "Image"
  image_uri    = "${aws_ecr_repository.lambda_ecr_repo.repository_url}:latest" # Update with your ECR image URL

  # Set Lambda timeout and memory size
  memory_size = 128
  timeout     = 30

  ephemeral_storage {
    size = 1024
  }

  # Environment variables (optional)
  environment {
    variables = {
      LOG_LEVEL = "INFO"
      PORT      = 3000
    }
  }

  depends_on = [time_sleep.wait_for_deployment]
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name      = aws_lambda_function.lambda_docker.function_name
  authorization_type = "NONE"

  cors {
    allow_origins = ["*"]
    allow_methods = ["*"]
  }
}