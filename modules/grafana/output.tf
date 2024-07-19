output "graf_lb_dns_name" {
  value = aws_lb.grafana-lb.dns_name
}

output "graf_lb_zoneid" {
  value = aws_lb.grafana-lb.zone_id
}