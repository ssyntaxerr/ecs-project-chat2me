provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "aws_ecr_repository" "ecr_repo" {
    name = "${var.project_name}-repo"
    force_delete = true
}

resource "aws_acm_certificate" "cert" {
  domain_name = var.domain_name
  subject_alternative_names = var.subdomain != "" ? [var.subdomain] : null
  validation_method = "DNS"

  tags = {
    Name = "${var.project_name}-cert"
  }
}

resource "cloudflare_record" "acm_validation" {
  zone_id = data.cloudflare_zones.example[0].id
  name    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  value   = aws_acm_certificate.cert.domain_validation_options[0].resource_record_value
  ttl     = 120
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [cloudflare_record.acm_validation.fqdn]
}