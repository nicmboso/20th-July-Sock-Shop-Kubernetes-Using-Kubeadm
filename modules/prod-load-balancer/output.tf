output "prod-lb-dns" {
  value = aws_lb.prod-lb.dns_name
}

output "prod-lb-arn" {
  value = aws_lb.prod-lb.arn
}

output "prod-lb-zoneid" {
  value = aws_lb.prod-lb.zone_id  
}

output "tg-prod-arn" {
  value = aws_lb_target_group.lb-tg-prod.arn
}