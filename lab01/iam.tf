resource "aws_iam_instance_profile" "this" {
  name = "aws-elasticbeanstalk-ec2-role"
  role = aws_iam_role.this.name
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name               = "aws-elasticbeanstalk-ec2-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.this.json
}