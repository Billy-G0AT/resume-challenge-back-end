#* Route53 Zone
resource "aws_route53_zone" "this" {
  name = var.domain
}

#* Domain Record
resource "aws_route53_record" "domain" {
  name    = var.domain
  type    = "A"
  zone_id = aws_route53_zone.this.zone_id

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

#* Subdomain Record
resource "aws_route53_record" "subdomain" {
  name    = var.subdomain
  type    = "A"
  zone_id = aws_route53_zone.this.zone_id

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}
