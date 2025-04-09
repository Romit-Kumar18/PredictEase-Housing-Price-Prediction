resource "aws_instance" "ecs_instance" {
  ami = "ami-071226ecf16aa7d96"
  instance_type = "t2.micro"
  key_name = "my-key"
  iam_instance_profile = aws_iam_instance_profile.ecs_profile.name
  vpc_security_group_ids = [aws_security_group.ecs_sg.id]
  subnet_id = aws_subnet.my_subnet_1.id

  user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y amazon-linux-extras
            amazon-linux-extras enable ecs
            yum install -y ecs-init
            echo "ECS_CLUSTER=my-ecs-cluster" >> /etc/ecs/ecs.config
            systemctl enable ecs
            systemctl start ecs

            mkfs -t ext4 /dev/xvdf
            mkdir /mnt/ecs-storage
            mount /dev/xvdf /mnt/ecs-storage

            echo "/dev/xvdf /mnt/ecs-storage ext4 defaults,nofail 0 2" >> /etc/fstab
            EOF
    
    tags = {
      Name = "ecs-instance"
    }
}

resource "aws_volume_attachment" "docker_volume_attach" {
  depends_on = [ aws_ebs_volume.docker_volume ]
  device_name = "/dev/xvdf"
  volume_id = aws_ebs_volume.docker_volume.id
  instance_id = aws_instance.ecs_instance.id
  force_detach = true
}