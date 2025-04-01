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
        ports = [{ container_port = 3000 }]
        environment = [{
            name = "NEXT_PUBLIC_BACKEND_URL", value = "http://backend:5000"
        }]
    },
    {
        name = "backend"
        image = "romitkumar18/predictease-housing-price-prediction-backend:latest"
        ports = [{ container_port = 5000 }]
        environment = [{
            name = "ML_SERVICE_URL", value = "http://ml-service:8000"
        }]
    },
    {
        name = "ml-service"
        image = "romitkumar18/predictease-housing-price-prediction-ml-service:latest"
        ports = [{ container_port = 8000 }]
    }
  ])
}