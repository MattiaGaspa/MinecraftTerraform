#!/bin/bash
terraform init
terraform validate
terraform plan -out=out.tfplan
terraform apply --auto-approve out.tfplan
terraform output --raw ansible_inventory > inventory
ansible-playbook -i inventory playbook.yml --check # sshpass must be installed