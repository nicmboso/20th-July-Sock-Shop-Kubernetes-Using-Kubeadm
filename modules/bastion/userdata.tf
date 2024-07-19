locals {
  bastion-userdata = <<-EOF
#!/bin/bash
echo "${var.private-key}" >> /home/ubuntu/.ssh/id_rsa
sudo chmod 400 /home/ubuntu/.ssh/id_rsa
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
sudo hostnamectl set-hostname Bastion
EOF
}