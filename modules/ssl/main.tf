data "aws_route53_zone" "route53_zone" {
  name = var.domain_name1
  private_zone = false
}

resource "aws_acm_certificate" "acm-cert" {
  domain_name = var.domain_name1
  subject_alternative_names = [var.domain_name2]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}


#attaching route53 and the certificate- connecting route53 to the certificate
resource "aws_route53_record" "cert-record" {
  for_each = {
    for anybody in aws_acm_certificate.acm-cert.domain_validation_options : anybody.domain_name => {
    name = anybody.resource_record_name
    record =anybody.resource_record_value
    type = anybody.resource_record_type 
  }
}
allow_overwrite  = true 
name   = each.value.name
records   = [each.value.record]
ttl   =60
type   =  each.value.type
zone_id     =  data.aws_route53_zone.route53_zone.zone_id
}

resource "aws_acm_certificate_validation" "valid-acm-cert" {
  certificate_arn = aws_acm_certificate.acm-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert-record : record.fqdn] 
}