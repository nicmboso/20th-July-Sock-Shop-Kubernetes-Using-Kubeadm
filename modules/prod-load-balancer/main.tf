# Creating Application Load Balancer for ASG Prod
resource "aws_lb" "prod-lb" {
  name                       = var.name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.prod-sg]
  subnets                    = var.subnet
  enable_deletion_protection = false

  tags = {
    Name = var.name
  }
}

# Creating Load Balancer Target Group for ASG Prod
resource "aws_lb_target_group" "lb-tg-prod" {
  name     = "lb-tg-prod"
  port     = 30002
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }
}

# Creating Load Balancer Listener for HTTP with redirect to HTTPS
resource "aws_lb_listener" "lb_lsnr-http" {
  load_balancer_arn = aws_lb.prod-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Creating Load Balancer Listener for HTTPS
resource "aws_lb_listener" "lb_lsnr-https" {
  load_balancer_arn = aws_lb.prod-lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.cert-arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg-prod.arn
  }
}

#Creating target group attachment
resource "aws_lb_target_group_attachment" "prod-lb-attachment" {
  target_group_arn = aws_lb_target_group.lb-tg-prod.arn
  target_id = element(split(",", join(",", "${var.instance}")), count.index)
  port = 30002
  count = 3
}