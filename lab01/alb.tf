###
# GROWTH ALB PUBLIC
###
resource "aws_lb" "this" {
  name               = "${var.project}-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_alb.id]

  subnets = module.vpc.public_subnets
}

# TARGET GROUP
resource "aws_lb_target_group" "this" {
  name        = "${var.env}-public-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

  health_check {
    path    = "/"
    matcher = "200"
  }
  tags = {
    Name = "${var.env}-public-tg"
  }
}

# LISTENER
resource "aws_lb_listener" "public_listener_http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:381491918721:targetgroup/awseb-test-lab-default-xqx2c/d559411cb0f763bd"
  }
}

