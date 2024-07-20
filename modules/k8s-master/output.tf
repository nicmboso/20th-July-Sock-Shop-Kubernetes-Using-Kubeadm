output "k8s-ips" {
  value = aws_instance.k8s-master.*.private_ip
}