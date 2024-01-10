# The entire section create a certificate, public zone, and validate the certificate using DNS method

# Create the certificate using a wildcard for all the domains created in drae-devops.com
resource "aws_acm_certificate" "drae-devops" {
  domain_name       = "*.drae-devops.com"
  validation_method = "DNS"
}

# calling the hosted zone
data "aws_route53_zone" "drae-devops" {
  name         = "drae-devops.com"
  private_zone = false
}

# selecting validation method
resource "aws_route53_record" "drae-devops" {
  for_each = {
    for dvo in aws_acm_certificate.drae-devops.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.drae-devops.zone_id
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "drae-devops" {
  certificate_arn         = aws_acm_certificate.drae-devops.arn
  validation_record_fqdns = [for record in aws_route53_record.drae-devops : record.fqdn]
}

# create records for tooling
resource "aws_route53_record" "tooling" {
  zone_id = data.aws_route53_zone.drae-devops.zone_id
  name    = "tooling.drae-devops.com"
  type    = "A"

  alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
  }
}

# create records for wordpress
resource "aws_route53_record" "wordpress" {
  zone_id = data.aws_route53_zone.drae-devops.zone_id
  name    = "wordpress.drae-devops.com"
  type    = "A"

  alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
  }
}