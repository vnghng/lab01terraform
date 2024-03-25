terraform {
  required_version = ">= 1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.19"
    }
  }
  backend "s3" {
    bucket         = "nghianv.381491918721-iac"
    key            = "terraform.nghianv2.test.lz.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  default_tags {
    tags = {
      Project     = var.project
      Environment = var.env
    }
  }
}
data "aws_caller_identity" "current" {}