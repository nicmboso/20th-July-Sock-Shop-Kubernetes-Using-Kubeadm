# Ansible SG
resource "aws_security_group" "ansible-sg" {
  name        = var.ansible-sg
  description = "Ansible Security Group"
  vpc_id      = var.vpc-id

  # Inbound Rules
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.ansible-sg
  }
}

# k8s SG
resource "aws_security_group" "k8s-sg" {
  name        = var.k8s-sg
  description = "k8s Security Group"
  vpc_id      = var.vpc-id

  # Inbound Rules
  ingress {
    description = "ssh access"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.k8s-sg
  }
}

# Bastion SG
resource "aws_security_group" "bastion-sg" {
  name        = var.bastion-sg
  description = "bastion Security Group"
  vpc_id      = var.vpc-id

  # Inbound Rules
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.bastion-sg
  }
}


