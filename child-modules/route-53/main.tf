# Create  a record for the hosted zone
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.domain-name.zone_id
  name    = "www.${data.aws_route53_zone.domain-name.name}"
  type    = "A"

  alias {
    name = var.alb-dns-name
    zone_id = var.alb-zone-id
    evaluate_target_health = true
  }
}
