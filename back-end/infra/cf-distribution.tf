#* Certificate
resource "aws_acm_certificate" "this" {
  provider                  = aws.east
  domain_name               = var.domain
  validation_method         = "DNS"
  subject_alternative_names = [var.domain, var.subdomain]
}

#* Cloudfront Distribution
resource "aws_cloudfront_distribution" "this" {
  aliases         = [var.domain, var.subdomain]
  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
    ]
    # ID For Default Cache Optimized Policy
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    cached_methods = [
      "GET",
      "HEAD",
    ]
    compress = true
    # Changes Cache Time, will leave for future reference
    # default_ttl            = 
    # max_ttl                = 
    # min_ttl                = 
    smooth_streaming       = false
    target_origin_id       = aws_s3_bucket_website_configuration.this.website_endpoint
    trusted_key_groups     = []
    trusted_signers        = []
    viewer_protocol_policy = "redirect-to-https"
  }

  origin {
    connection_attempts = 3
    connection_timeout  = 10
    domain_name         = aws_s3_bucket_website_configuration.this.website_endpoint
    origin_id           = aws_s3_bucket_website_configuration.this.website_endpoint

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1.2",
      ]
    }
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.this.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}
