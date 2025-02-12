provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "chennai_api_cluster" {
  name = "chennai-api-cluster"
}

resource "aws_ecs_task_definition" "chennai_api_task" {
  family                   = "chennai-api-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "chennai-api"
      image = "your-dockerhub-username/chennai-price-api:latest"
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "chennai_api_service" {
  name            = "chennai-api-service"
  cluster         = aws_ecs_cluster.chennai_api_cluster.id
  task_definition = aws_ecs_task_definition.chennai_api_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["subnet-xxxxx"]
    security_groups = ["sg-xxxxx"]
    assign_public_ip = true
  }
}