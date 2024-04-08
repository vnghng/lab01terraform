locals {
  domain = "nghianv2-test.f88.co"
}

locals {
  ami_id            = "ami-04ddf30efb5385f93"
  ec2_instance_type = "t3.micro"
  az                = "ap-southeast-1a"
  ebs_volume_size   = 10
  ebs_iops          = 3000
  ebs_volume_type   = "gp3"
  sg_cidr           = ["172.19.0.0/16"]
  sg_allow = ["0.0.0.0/0"]
  certarn = "arn:aws:acm:ap-southeast-1:356705062463:certificate/5154c70f-4377-459f-8661-92ff02e72d6a"
}

locals {
  vpc_cidr         = "172.19.0.0/16"
  public_subnets   = ["172.19.48.0/20", "172.19.64.0/20", "172.19.80.0/20"]
  private_subnets  = ["172.19.96.0/20", "172.19.112.0/20", "172.19.128.0/20"]
  database_subnets = ["172.19.144.0/20", "172.19.160.0/20", "172.19.176.0/20"]
}