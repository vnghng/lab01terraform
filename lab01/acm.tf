resource "aws_acm_certificate" "this" {
  domain_name               = "nghianv2.com"
  subject_alternative_names = ["*.nghianv2.com", "www.nghianv2.com"]
  validation_method         = "DNS"
  key_algorithm             = null
  #  validation_option         = {}
  tags = {
    Name        = "${var.env}-acm"
    Environment = var.env
    Project     = var.project
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}
