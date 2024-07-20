output "ansible-sg" {
  value = aws_security_group.ansible-sg.id
}
output "k8s-sg" {
  value = aws_security_group.k8s-sg.id
}
output "bastion-sg" {
  value = aws_security_group.bastion-sg.id
}