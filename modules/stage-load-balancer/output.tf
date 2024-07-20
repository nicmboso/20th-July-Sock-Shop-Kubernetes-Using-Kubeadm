output "stage-alb-arn" {
  value = aws_lb.stage-alb.arn
}

output "stage-tg-arn" {
  value = aws_lb_target_group.lb-tg-stage.arn

}
output "alb-stage-dns" {
  value = aws_lb.stage-alb.dns_name
}

output "alb-stage-zoneid" {
  value = aws_lb.stage-alb.zone_id  
}

