locals {
  domain = "nghianv2-test.com"
}

locals {
  ami_id            = "ami-04ddf30efb5385f93"
  ec2_instance_type = "t3.micro"
  az                = "ap-southeast-1a"
  ebs_volume_size   = 10
  ebs_iops          = 3000
  ebs_volume_type   = "gp3"
  sg_cidr           = ["172.19.0.0/16"]

  sg_allow = [
    "172.19.0.0/16"
  ]
}
