# Настройка блокировки состояния в бакете S3
terraform {
  backend "s3" {
    bucket         = "bandzzz-terraform-state-bucket-202501"
    key            = "dev/eks-cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "bandzzz_terraform_lock_table"
    encrypt        = true
  }
}
