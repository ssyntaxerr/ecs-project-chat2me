resource "aws_ecr_repository" "ecr_repo" {
    name = "${var.project_name}-repo"
    force_delete = true
}