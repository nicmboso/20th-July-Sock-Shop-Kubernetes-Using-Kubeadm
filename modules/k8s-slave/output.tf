output "k8s-ips" {
  value = aws_instance.k8s-worker.*.private_ip
}

output "k8s-ids" {
  value = aws_instance.k8s-worker.*.id
}