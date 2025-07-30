terraform {
  backend "s3" {
    bucket         = "mahesh-terraform-state-20250729"
    key            = "infra/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}

