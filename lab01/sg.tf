module "rds_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.env}-rds-sg"
  description = "SG for ${var.env}-public-rds"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "elastic-beanstalk_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.env}-elastic-beanstalk-sg"
  description = "SG for ${var.env}-elastic-beanstalk"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 80
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "alb_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.env}-alb-sg"
  description = "SG for ${var.env}-alb"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}