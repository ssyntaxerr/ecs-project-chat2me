variable "aws_region" {
    description = "AWS region"
    type = string
    default = "eu-north-1"
}

variable "project_name" {
    description = "Name prefix for all resources"
    type = string
}

variable "container_port" {
    description = "Port on which the container will listen"
    type = number
}

variable "domain_name" {
    type = string 
}

variable "subject_alternative_names" {
    type = list(string)
}

variable "vpc_cidr" {
    description = "Defines IP address range for VPC"
    type = string
    default = "10.0.0.0/16"
}