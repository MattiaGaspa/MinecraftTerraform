#!/bin/bash
terraform init
terraform validate
terraform plan -out=out.tfplan
terraform apply --auto-approve out.tfplan
terraform output --raw ansible_inventory > inventory
sleep 5 # DO NOT REMOVE
ansible-playbook -i inventory playbook.yml # sshpass must be installed
echo -n "Connect to server: " && terraform output --raw public_ip