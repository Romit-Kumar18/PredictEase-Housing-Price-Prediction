resource "aws_autoscaling_group" "ecs_asg" {
  vpc_zone_identifier = [ aws_subnet.my_subnet_1.id, aws_subnet.my_subnet_2.id ]
  desired_capacity = 1
  max_size = 1
  min_size = 1

  lifecycle {
    create_before_destroy = true
  }

  launch_template {
    id = aws_launch_template.ecs_instance_template.id
    version = "$Latest"
  }

  tag {
    key = "AmazonECSManaged"
    value = true
    propagate_at_launch = true
  }
}