resource "aws_ecs_service" "my_service" {
  name = "my-ecs-service"
  cluster = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count = 1
  launch_type = "EC2"
}