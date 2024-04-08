module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = local.domain
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  attach_policy                            = true
  policy                                   = data.aws_iam_policy_document.bucket_policy.json
  versioning = {
    enabled = true
  }
}