

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket         = "ascendo-assesment-tfstate-bucket"
    key            = "ascendo-assesment-tfstate-bucket/terraform.tf/tfstate"
    region         = "eu-north-1"
  }
}