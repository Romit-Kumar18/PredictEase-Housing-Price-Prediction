output "instance_id" {
  value = aws_instance.ecs_instance.id
}

output "instance_public_ip" {
  value = aws_instance.ecs_instance.public_ip
}