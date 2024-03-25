resource "aws_route53_zone" "primary" {
  name = "nghianv2.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "test.nghianv2.com"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.this.dns_name]
}

resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.primary.zone_id
}

#resource "aws_acm_certificate_validation" "example" {
#  certificate_arn         = aws_acm_certificate.this.arn
#  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
#}
