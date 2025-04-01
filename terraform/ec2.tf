resource "aws_instance" "ecs_instance" {
  ami = "ami-071226ecf16aa7d96"
  instance_type = "t2.micro"
  key_name = "my-key"
  iam_instance_profile = aws_iam_instance_profile.ecs_profile.name
  security_groups = [aws_security_group.ecs_sg.name]

  user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y amazon-linux-extras
            amazon-linux-extras enable ecs
            yum install -y ecs-init
            systemctl enable --now ecs
            echo "ECS_CLUSTER=my-ecs-cluster" >> /etc/ecs/ecs.config
            EOF
    
    tags = {
      Name = "ecs-instance"
    }
}