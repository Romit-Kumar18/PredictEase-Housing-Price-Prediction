resource "aws_ecs_task_definition" "my_task" {
  family = "my-ecs-task"
  requires_compatibilities = [ "EC2" ]
  network_mode = "bridge"
  cpu = "512"
  memory = "1024"
  
  container_definitions = jsonencode([
    {
        name = "frontend"
        image = "romitkumar18/predictease-housing-price-prediction-frontend:latest"
        portMappings = [{
            containerPort = 3000
            hostPort = 3000
        }]
        environment = [{
            name = "NEXT_PUBLIC_BACKEND_URL", value = "http://localhost:5000"
        }]
        essential = true
    },
    {
        name = "backend"
        image = "romitkumar18/predictease-housing-price-prediction-backend:latest"
        portMappings = [{
            containerPort = 5000
            hostPort = 5000
        }]
        environment = [{
            name = "ML_SERVICE_URL", value = "http://localhost:8000"
        }]
        essential = true
    },
    {
        name = "ml-service"
        image = "romitkumar18/predictease-housing-price-prediction-ml-service:latest"
        portMappings = [{
            containerPort = 8000
            hostPort = 8000
        }]
        essential = true
    }
  ])
}