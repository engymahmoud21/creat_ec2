provider "aws" {
  region = "us-weast-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  #region     = var.aws_region
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4"
    }
  }
}
