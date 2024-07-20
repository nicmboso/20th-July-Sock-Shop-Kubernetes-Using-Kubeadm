output "prom_lb_dns_name" {
  value = aws_lb.prometheus-lb.dns_name
}

output "prom_lb_zoneid" {
  value = aws_lb.prometheus-lb.zone_id
}