data "aws_instance" "ecs_instance" {
  instance_id = aws_instance.ecs_instance.id
}

resource "null_resource" "update_inventory" {
  depends_on = [aws_instance.ecs_instance]

  provisioner "local-exec" {
    command = <<EOT
      sleep 15
      echo "[ecs_instance]" | tee ../ansible/inventory.ini
      echo "${data.aws_instance.ecs_instance.public_ip}" | tee -a ../ansible/inventory.ini
    EOT
  }
}