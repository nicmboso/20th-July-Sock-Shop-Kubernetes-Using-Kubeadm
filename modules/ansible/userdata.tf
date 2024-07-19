locals {
 user_data = <<-EOF
#!/bin/bash

# update instance and install ansible
sudo apt-get update -y
sudo apt-get install software-properties-common -y
sudo apt-get-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y
mkdir /etc/ansible
sudo chown ubuntu:ubuntu /etc/ansible

# copying keypair
echo "${var.private-key}" >> /home/ubuntu/.ssh/id_rsa
sudo chmod 400 /home/ubuntu/.ssh/id_rsa
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa

# create anisble inventory file
echo "[all:vars]" > /etc/ansible/hosts
echo "ansible_ssh_common_args='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'" >> /etc/ansible/hosts
echo "[HAproxy1]" >> /etc/ansible/hosts
echo "${var.haproxy1} ansible_user=ubuntu" >> /etc/ansible/hosts
echo "[HAproxy2]" >> /etc/ansible/hosts
echo "${var.haproxy2} ansible_user=ubuntu" >> /etc/ansible/hosts
echo "[Master1]" >> /etc/ansible/hosts
echo "${var.master1} ansible_user=ubuntu" >> /etc/ansible/hosts
echo "[Master2-3]" >> /etc/ansible/hosts
echo "${var.master2} ansible_user=ubuntu" >> /etc/ansible/hosts
echo "${var.master3} ansible_user=ubuntu" >> /etc/ansible/hosts
echo "[Workers]" >> /etc/ansible/hosts
echo "${var.worker1} ansible_user=ubuntu" >> /etc/ansible/hosts
echo "${var.worker2} ansible_user=ubuntu" >> /etc/ansible/hosts
echo "${var.worker3} ansible_user=ubuntu" >> /etc/ansible/hosts

# create ansible variable file
echo HAPROXY1: "${var.haproxy1}" > /home/ubuntu/haproxy_ips.yml
echo HAPROXY2: "${var.haproxy2}" >> /home/ubuntu/haproxy_ips.yml

# execute playbooks
sudo su -c "ansible-playbook /home/ubuntu/playbooks/kube-install.yaml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/install-keepalived.yaml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/cluster-init.yaml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/add-other-masters.yaml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/add-workers.yaml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/kubectl-install.yaml" ubuntu

# deploy app in stage and prod environment
sudo su -c "ansible-playbook /home/ubuntu/playbooks/stage-env.yaml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/prod-env.yaml" ubuntu
sudo su -c "ansible-playbook /home/ubuntu/playbooks/monitoring.yaml" ubuntu

sudo hostnamectl set-hostname ansible
EOF
}