resource "aws_security_group" "ecs_sg" {
  name = "ecs-security-group"
  vpc_id = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "ecs_port_3000" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 3000
  ip_protocol = "tcp"
  to_port = 3000
}

resource "aws_vpc_security_group_ingress_rule" "ecs_port_5000" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4 = "10.0.0.0/16"
  from_port = 5000
  ip_protocol = "tcp"
  to_port = 5000
}

resource "aws_vpc_security_group_ingress_rule" "ecs_port_8000" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4 = "10.0.0.0/16"
  from_port = 8000
  ip_protocol = "tcp"
  to_port = 8000
}

resource "aws_vpc_security_group_ingress_rule" "ecs_http" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ecs_ssh" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4 = var.my_ip
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ecs_allow_outbound_ipv4" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}