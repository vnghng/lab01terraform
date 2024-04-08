resource "aws_key_pair" "deployer" {
  key_name   = "nghianv2"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZxYXCW0H4a36qUBSMUiDFy4UF7unv8X4uQRRn1+8zN f88\nghianv2@LHN-63-01-131"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  monitoring             = true
  vpc_security_group_ids = module.elastic-beanstalk_service_sg.security_group_id
  subnet_id              = "module.vpc.public_subnets"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
