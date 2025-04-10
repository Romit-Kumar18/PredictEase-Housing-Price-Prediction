resource "aws_security_group" "ecs_sg" {
  name = "ecs-security-group"
  vpc_id = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "ecs_allow_inbound_ipv4" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = -1
}

resource "aws_vpc_security_group_egress_rule" "ecs_allow_outbound_ipv4" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}