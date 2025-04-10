resource "aws_lb" "ecs_alb" {
  name = "aws-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.ecs_sg.id ]
  subnets = [ aws_subnet.my_subnet_1.id, aws_subnet.my_subnet_2.id ]

  tags = {
    Name = "ecs-alb"
  }
}

resource "aws_lb_target_group" "aws_tg" {
  name = "aws-lb-target-group"
  port = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = aws_vpc.main.id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "ecs_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.aws_tg.arn
  }
}