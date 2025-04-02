resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "My Route Table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }
}

resource "aws_route_table_association" "subnet1_route" {
  subnet_id = aws_subnet.my_subnet_1.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "subnet2_route" {
  subnet_id = aws_subnet.my_subnet_2.id
  route_table_id = aws_route_table.my_route_table.id
}