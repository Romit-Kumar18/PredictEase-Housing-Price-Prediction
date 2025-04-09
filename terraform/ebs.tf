resource "aws_ebs_volume" "docker_volume" {
  availability_zone = aws_instance.ecs_instance.availability_zone
  size = 20
  type = "gp2"
  tags = {
    Name: "docker-volume"
  }
}