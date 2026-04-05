variable "project_name" {
    type = string
}

variable "container_port" {
    type = number
}

variable "target_group_arn" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "repo_url" {
    type = string
}

variable "alb_sg_id" {
    type = string
}
 variable "image_tag" {
    type = string
 }

 variable "cpu" {
    type = number 
 }

 variable "memory" {
    type = number
 }

 variable "aws_region" {
    type = string
 }

 variable "private_subnet_ids" {
    type = list(string)
}