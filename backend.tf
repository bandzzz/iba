terraform {
  backend "s3" {
    bucket         = "bandzzz_terraform_state_202501"
    key            = "dev/eks-cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "bandzzz_terraform_lock_202501"
    encrypt        = true
  }
}
