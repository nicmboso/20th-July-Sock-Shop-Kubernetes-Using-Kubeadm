# Import route 53 hosted zone
data "aws_route53_zone" "route53_zone" {
  name         = "linuxclaud.com"
  private_zone = false
}

#Create route 53 A record for stage
resource "aws_route53_record" "stage-record" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = "stage.linuxclaud.com"
  type    = "A"
  alias {
    name                   = var.stage_lb_dns_name
    zone_id                = var.stage_lb_zoneid
    evaluate_target_health = false
  }
}

#Create route 53 A record for prod
resource "aws_route53_record" "prod-record" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = "prod.linuxclaud.com"
  type    = "A"
  alias {
    name                   = var.prod_lb_dns_name
    zone_id                = var.prod_lb_zoneid
    evaluate_target_health = false
  }
}

#Create route 53 A record for Grafana
resource "aws_route53_record" "grafana-record" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = "graf.linuxclaud.com"
  type    = "A"
  alias {
    name                   = var.graf_lb_dns_name
    zone_id                = var.graf_lb_zoneid
    evaluate_target_health = false
  }
}

#Create route 53 A record for Prometheus
resource "aws_route53_record" "prom-record" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = "prom.linuxclaud.com"
  type    = "A"
  alias {
    name                   = var.prom_lb_dns_name
    zone_id                = var.prom_lb_zoneid
    evaluate_target_health = false
  }
}