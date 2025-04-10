resource "aws_ecs_service" "my_service" {
  name = "my-ecs-service"
  cluster = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count = 1
  network_configuration {
    subnets = [ aws_subnet.my_subnet_1.id, aws_subnet.my_subnet_2.id ]
    security_groups = [ aws_security_group.ecs_sg.id ]
  }

  force_new_deployment = true

  triggers = {
    redeployment = timestamp()
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
    weight = 100
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.aws_tg.arn
    container_name = "frontend"
    container_port = 3000
  }

  depends_on = [ aws_autoscaling_group.ecs_asg ]
}