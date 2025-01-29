terraform {
  backend "s3" {
    bucket         = "bandzzz-terraform-state-bucket"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "bandzzz-dynamodb-lock-table"
    encrypt        = true
  }
}
