resource "null_resource" "db-deploy" {
  triggers = {
    instance_ids = aws_spot_instance_request.db.spot_instance_id
  }
  provisioner "remote-exec" {
    connection {
      timeout     = "4m"
      type        = "ssh"
      host        = aws_spot_instance_request.db.private_ip
      user        = "centos"
      private_key = file("~/.ssh/key")
    }

    inline = [
      "ansible-pull -U https://github.com/ChaitanyaChandra/ansible-lab.git spec-pull.yml -e COMPONENT=${var.DB_COMPONENT} -e ENV=${var.ENV} -i hosts"
    ]
  }
}
