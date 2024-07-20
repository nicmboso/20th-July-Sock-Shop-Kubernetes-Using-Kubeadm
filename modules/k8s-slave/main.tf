resource "aws_instance" "k8s-worker" {
  count                  = var.count-worker
  ami                    = var.ubuntu
  instance_type          = "t2.medium"
  subnet_id              = element(var.subnet_id, count.index)
  vpc_security_group_ids = [var.k8s-sg]
  key_name               = var.key-name
  tags = {
    Name = "${var.k8s-worker}${count.index}"
  }
}