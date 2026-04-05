variable "project_name" {
    type = string
}

variable "domain_name" {
    type = string
}

variable "subdomain" {
    type = string
}

variable "aws_region" {
    type = string
    default = "eu-north-1"
}

variable "cloudflare_api_token" {
    type = string
    sensitive = true
}