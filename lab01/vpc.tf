data "aws_availability_zones" "available" {}

locals {
  vpc_cidr         = "172.19.0.0/16"
  public_subnets   = ["172.19.48.0/20", "172.19.64.0/20", "172.19.80.0/20"]
  private_subnets  = ["172.19.96.0/20", "172.19.112.0/20", "172.19.128.0/20"]
  database_subnets = ["172.19.144.0/20", "172.19.160.0/20", "172.19.176.0/20"]

  endpoint_services = {
    gateways = [
      "com.amazonaws.ap-southeast-1.s3",
    ]
  }
}

module "vpc" {
  source = ".//modules/vpc"

  name = "${var.project}-${var.env}"
  cidr = local.vpc_cidr

  azs = data.aws_availability_zones.available.names

  public_subnets       = local.public_subnets
  private_subnets      = local.private_subnets
  database_subnets     = local.database_subnets
  enable_dns_hostnames = true

  enable_flow_log           = false
  flow_log_destination_type = "s3"

  tags = {
    Terraform = "true"
  }
}

