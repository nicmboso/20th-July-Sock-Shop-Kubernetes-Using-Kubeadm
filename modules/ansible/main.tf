#create ansible server
resource "aws_instance" "ansible" {
    ami                           = var.ubuntu
    instance_type                 = "t2.micro"
    subnet_id                     = var.subnet_id
    key_name                      = var.ssh_key
    vpc_security_group_ids        = [var.ansible-sg]
    user_data                     = local.user_data
    
    tags = {
        Name = var.ansible_name
    }
}
resource "null_resource" "copy_dir" {
  connection {
    type = "ssh"
    bastion_host = var.bastion
    bastion_private_key = var.private-key
    bastion_user = "ubuntu"
    host = aws_instance.ansible.private_ip
    private_key = var.private-key
    user = "ubuntu"
  }
  provisioner "file" {
    source = "./modules/ansible/playbooks"
    destination = "/home/ubuntu/"
  }
}