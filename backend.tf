# ----root/backend.tf ----
#This is the code that will migrate tfstate file to s3 bucket

terraform {
  backend "s3" {
    bucket = "learning-terraform2022-v2-state"
    key    = "s3/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "muykol01-tf-locks"
    encrypt        = true
  }
}
