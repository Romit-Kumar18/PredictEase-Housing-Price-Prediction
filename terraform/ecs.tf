resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster"

  depends_on = [ aws_autoscaling_group.ecs_asg ]
}