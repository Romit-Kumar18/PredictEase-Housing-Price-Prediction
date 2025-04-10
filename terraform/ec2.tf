resource "aws_launch_template" "ecs_instance_template" {
  name_prefix = "ecs-instance-template"
  image_id = "ami-0cf4380e9a9430646"
  instance_type = "t2.micro"
  key_name = "my-key"
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_profile.name
  }
  vpc_security_group_ids = [ aws_security_group.ecs_sg.id ]

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }
    
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ecs-instance"
    }
  }

  user_data = filebase64("${path.module}/ecs.sh")
}