resource "aws_instance" "haproxy1" {
  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id
  user_data = templatefile("./modules/haproxy/haproxy.sh", {
    server1 = var.server1,
    server2 = var.server2,
    server3 = var.server3
  })

  tags = {
    Name = var.haproxy-name
  }
}
resource "aws_instance" "haproxy2" {
  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id_2
  user_data = templatefile("./modules/haproxy/haproxy.sh", {
    server1 = var.server1,
    server2 = var.server2,
    server3 = var.server3
  })

  tags = {
    Name = var.haproxy-name2
  }
}
