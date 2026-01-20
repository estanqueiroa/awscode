# variable "aws_region" {
#   description = "AWS region"
#   type        = string
#   default     = "us-east-1"
# }

variable "bucket_name" {
  description = "bucket name prefix"
  type        = string

}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Project     = "s3-replication"
  }
}

