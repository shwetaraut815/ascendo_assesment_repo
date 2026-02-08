terraform {
  backend "s3" {
    bucket         = "ascendo-assesment-tfstate-bucket"
    key            = "ascendo-assesment-tfstate-bucket/terraform.tf/tfstate"
    region         = "eu-north-1"
    # dynamodb_table = "terraform-locks"
    # encrypt        = true
  }
}