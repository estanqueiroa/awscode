# providers.tf
terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"

    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Environment     = "Test"
      Service         = "Example"
      HashiCorp-Learn = "aws-default-tags"
      CreatedBy       = "Terraform"
    }
  }

}