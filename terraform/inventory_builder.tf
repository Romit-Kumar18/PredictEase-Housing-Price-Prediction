data "aws_instance" "ecs_instance" {
  instance_id = aws_instance.ecs_instance.id
}

resource "null_resource" "update_inventory" {
  depends_on = [aws_instance.ecs_instance]

  provisioner "local-exec" {
    command = <<EOT
      @echo off
      timeout /t 15 /nobreak >nul
      echo [ecs_instance] > ..\ansible\inventory.ini
      echo %data.aws_instance.ecs_instance.public_ip% >> ..\ansible\inventory.ini
    EOT
  }
}
