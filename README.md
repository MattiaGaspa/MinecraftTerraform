# MinecraftTerraform
Terraform Code for creating a Minecraft server on Azure.

## Requirements

Create an Azure account first.

Then install:

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [sshpass](https://www.redhat.com/en/blog/ssh-automation-sshpass)

## Server creation

WRITE BETTER

Login with the `az` utility:

``` bash
az login
```

Create a `terraform.tfvars` file where you will write:

```
vm_admin_username = "YOUR ADMIN USERNAME"
vm_admin_password = "YOUR ADMIN PASSWORD"
```

Other variables that you can set up are:

- `rg_name`: The resource group's name.
- `vm_size`: The size of the virtual machine. By default: `Standard_B4ms`. Other values can be found [here](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/compute-benchmark-scores)

Run the script `create.sh` to create the server:

``` bash
chmod +x ./create.sh
./create.sh
```

## Server deallocation

To avoid being billed when you don't use the server, run:

``` bash
TODO
```

## Server restart

To start the server after deallocation, run:

``` bash
TODO
```

## Server deletion

Run:

``` bash
terraform destroy
```

This command requires confirmation, be aware that your world will be lost.

## Changing minecraft version

Open the `playbook.yml` file and set up the variables.