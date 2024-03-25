resource "aws_key_pair" "deployer" {
  key_name   = "nghianv2"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZxYXCW0H4a36qUBSMUiDFy4UF7unv8X4uQRRn1+8zN f88\nghianv2@LHN-63-01-131"
}

resource "aws_instance" "this" {
  ami                    = local.ami_id
  instance_type          = local.ec2_instance_type
  availability_zone      = local.az
  subnet_id              = module.vpc.public_subnets [0]
  vpc_security_group_ids = [
    aws_security_group.elastic_beanstalk.id
  ]
  key_name             = "nghianv2"
  monitoring           = true

  root_block_device {
    delete_on_termination = true
    iops                  = local.ebs_iops
    volume_size           = local.ebs_volume_size
    volume_type           = local.ebs_volume_type
  }

  tags = {
    Name        = "${var.env}-${var.project}"
    Environment = var.env
    Project     = var.project
    Managed     = "Terraform"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
