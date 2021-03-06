# --- root/main.tf -----


provider "aws" {
  region = var.region
}

module "networking" {
  source   = "./networking"
  vpc_cidr = "10.124.0.0/16"
}

#1 -this will create a S3 bucket in AWS
resource "aws_s3_bucket" "terraform_state_s3" {
  #make sure you give unique bucket name
  bucket        = "learning-terraform2022-v2-state"
  force_destroy = true
  # Enable versioning to see full revision history of our state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# 2 - this Creates Dynamo Table
resource "aws_dynamodb_table" "terraform_locks" {
  # Give unique name for dynamo table name
  name         = "muykol01-tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
