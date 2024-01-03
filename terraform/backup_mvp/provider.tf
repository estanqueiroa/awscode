terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"

  default_tags {
    tags = {
      Environment = "Development"
      Owner       = "John"
      Project     = "Backup"
      Terraform   = "True"
      Client      = "Internal"
      Repo = "/mnt/c/aws/santander/backup"
    }
  }

}