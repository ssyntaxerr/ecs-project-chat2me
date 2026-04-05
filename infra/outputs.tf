output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "repo_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.repo_url
}

output "certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = module.acm.certificate_arn
}

output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "target_group_arn" {
  description = "The ARN of the ALB target group"
  value       = module.alb.target_group_arn
}

output "alb_sg_id" {
  description = "The security group ID of the ALB"
  value       = module.alb.alb_sg_id
}
