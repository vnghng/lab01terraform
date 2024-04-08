module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

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

