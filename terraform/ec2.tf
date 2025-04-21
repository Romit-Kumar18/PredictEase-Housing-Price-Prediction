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
    volume_type = "gp3"
  }
  tags = {
    Name = "ecs-instance"
  }

  user_data = <<-EOF
    #!/bin/bash

    exec > /var/log/user-data.log 2>&1
    set -x

    sudo yum update -y
    sudo yum install -y git libffi libffi-devel openssl-devel libxcrypt-compat chkconfig
    sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    sudo chkconfig docker on
    sudo service docker start

    docker pull romitkumar18/predictease-housing-price-prediction-frontend:latest
    docker pull romitkumar18/predictease-housing-price-prediction-backend:latest
    docker pull romitkumar18/predictease-housing-price-prediction-ml-service:latest
    docker pull romitkumar18/predictease-housing-price-prediction-nginx:latest

    git clone https://github.com/Romit-Kumar18/PredictEase-Housing-Price-Prediction.git /opt/predictease

    cd /opt/predictease/terraform
    sleep 10
    sudo docker-compose up -d
    EOF

}