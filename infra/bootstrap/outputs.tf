output "repo_url" { value = aws_ecr_repository.ecr_repo.repository_url }

output "acm_certificate_arn" { value = aws_acm_certificate.cert.arn }