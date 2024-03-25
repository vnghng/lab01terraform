resource "aws_security_group" "public_alb" {
  name        = "${var.env}-public-alb-sg"
  description = "SG for ${var.env}-public-alb"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.env}-public-alb-sg"
    Environment = var.env
    Project     = var.project
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


## security group for grafana
resource "aws_security_group" "this" {
  vpc_id      = module.vpc.vpc_id
  name        = "${var.env}-grafana-sg"
  description = "sg for grafana"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = local.sg_cidr
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.sg_allow
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.env}-grafana-sg"
    Environment = var.env
    Project     = var.project
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


# SG RDS
resource "aws_security_group" "sg_rds_cs" {
  name        = "${var.env}-${var.project}-rds-sg"
  description = "SG for ${var.env}-${var.project}-rds"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = local.sg_cidr
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = local.sg_cidr
  }

  tags = {
    Name        = "${var.env}-${var.project}-rds-sg"
    Environment = var.env
    Project     = var.project
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

## security group for elastic Beanstalk
resource "aws_security_group" "elastic_beanstalk" {
  vpc_id      = module.vpc.vpc_id
  name        = "${var.env}-elastic-beanstalk-sg"
  description = "sg for elastic beanstalk"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = local.sg_cidr
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.sg_allow
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.env}-elastic-beanstalk-sg"
    Environment = var.env
    Project     = var.project
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}