output "cluster_id" { value = aws_ecs_cluster.ecs_cluster.id }
output "service_name" { value = aws_ecs_service.service.name }