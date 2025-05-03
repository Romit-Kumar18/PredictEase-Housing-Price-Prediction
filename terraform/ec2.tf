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
    Name = "k8s-instance"
  }

  user_data = <<-EOF
    #!/bin/bash

    exec > /var/log/user-data.log 2>&1
    set -x

    sudo yum update -y
    sudo yum install -y git

    curl -sfL https://get.k3s.io | sh -

    sleep 30

    export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

    git clone https://github.com/Romit-Kumar18/PredictEase-Housing-Price-Prediction.git /opt/predictease

    sleep 15

    kubectl apply -f /opt/predictease/k8s/
  EOF

}