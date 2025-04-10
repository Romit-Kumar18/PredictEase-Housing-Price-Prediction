resource "aws_instance" "ecs_instance" {
  ami = "ami-0cf4380e9a9430646"
  instance_type = "t2.micro"
  key_name = "my-key"
  iam_instance_profile = aws_iam_instance_profile.ecs_profile.name
  vpc_security_group_ids = [aws_security_group.ecs_sg.id]
  subnet_id = aws_subnet.my_subnet_1.id

  ebs_block_device {
    device_name = "/dev/xvda"
    delete_on_termination = true
    volume_size = 30
    volume_type = "gp2"
  }
  tags = {
    Name = "ecs-instance"
  }

  user_data = file("docker_pull.sh")
}