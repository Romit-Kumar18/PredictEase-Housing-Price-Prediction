resource "aws_subnet" "my_subnet_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, 2)
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "Public Subnet 2"
  }
}