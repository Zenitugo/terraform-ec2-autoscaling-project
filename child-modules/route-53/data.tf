 
 # Check for your hosted zone in aws
 data "aws_route53_zone" "domain-name" {
  name         = var.domain-name
  private_zone = false
}
