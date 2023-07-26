terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "useast1"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::520291287938:role/ProdFullAccess"
    session_name = "Terraform-ProdUpdate"
  }
}