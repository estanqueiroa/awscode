terraform {
  backend "s3" {
    bucket  = "terraform-state-estanqua"
    key     = "s3-replication/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
