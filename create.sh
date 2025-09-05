#!/bin/bash
terraform init
terraform validate
terraform plan -out=out.tfplan
terraform apply --auto-approve out.tfplan
terraform output --raw ansible_inventory > inventory

while true; do
  if nc -z "$(terraform output --raw public_ip)" 22 2>/dev/null; then
    break
  fi
  echo "Waiting for host."
done

ansible-playbook -i inventory playbook.yml # sshpass must be installed
echo -n "Connect to server: " && terraform output --raw public_ip