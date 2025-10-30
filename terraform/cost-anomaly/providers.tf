


provider "aws" {
  region = local.aws_region

  default_tags {

    tags = {

      "managed_by"  = "AFT"
      "current_dir" = local.current_dir

    }
  }
}
