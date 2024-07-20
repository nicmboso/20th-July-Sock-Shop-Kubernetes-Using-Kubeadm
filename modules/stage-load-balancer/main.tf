# Creating Application Load Balancer for k8s stage
resource "aws_lb" "stage-alb" {
  name                       = "k8s-stage-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.stage-sg]
  subnets                    = var.subnet
  enable_deletion_protection = false

  tags = {
    Name = var.name-stage-alb
  }
}

# Creating Load Balancer Target Group for k8s stage
resource "aws_lb_target_group" "lb-tg-stage" {
  name     = "lb-tg-stage"
  port     = 30001
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }
}

# Creating Load Balancer Target Group Attachment
resource "aws_lb_target_group_attachment" "tg_att" {
  target_group_arn = aws_lb_target_group.lb-tg-stage.arn
  target_id        = element(split(",", join(",", "${var.instance}")), count.index)
  port             = 30001
  count = 3
}

#Creating Load Balancer Listener for https
resource "aws_lb_listener" "lb_lsnr-https" {
  load_balancer_arn = aws_lb.stage-alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.cert-arn

  default_action {
    type             = "forward"
      target_group_arn = aws_lb_target_group.lb-tg-stage.arn
  }
}

# Creating Load Balancer Listener for http
resource "aws_lb_listener" "lb_lsnr-http" {
  load_balancer_arn = aws_lb.stage-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg-stage.arn
  }
}


