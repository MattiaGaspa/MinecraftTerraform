#!/bin/bash
terraform init
terraform validate
terraform plan -out=out.tfplan
terraform apply --auto-approve out.tfplan
IP=$(terraform output --raw public_ip)
USER=$(terraform output --raw vm_admin_username)
PASS=$(terraform output --raw vm_admin_password)
RG_NAME=$(terraform output --raw resource_group_name)
terraform output --raw ansible_inventory > inventory

while true; do
  if nc -z "$(terraform output --raw public_ip)" 22 2>/dev/null; then
    break
  fi
  echo "Waiting for host."
done

ansible-playbook -i inventory playbook.yml # sshpass must be installed
echo -n "Connect to server: ${IP}"

echo "az vm deallocate --resource-group ${RG_NAME} --name MinecraftServerVM" > deallocate.sh
echo "az vm start --resource-group ${RG_NAME} --name MinecraftServerVM" > start.sh