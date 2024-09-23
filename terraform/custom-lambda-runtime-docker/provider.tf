provider "aws" {
  alias  = "source"
  region = var.region
  #profile = "<source-profile-name>"


  default_tags {
    tags = {
      Environment = "Development"
      Owner       = "John"
      Project     = "Backup"
      Terraform   = "True"
      Client      = "Internal"
      Repo        = "/mnt/c/aws/awscode/terraform/custom-lambda-runtime-docker/"
    }
  }

}