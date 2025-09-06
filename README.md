# MinecraftTerraform
Terraform Code and Ansible Playbook for creating a Minecraft server on Azure.

## Requirements

Create an Azure account first.

Then install the dependencies:

```
sudo apt update
sudo apt install python3.10 python3.10-venv python3.10-distutils sshpass
```

Run:

```
python3.10 -m venv .venv
source .venv/bin/activate
pip install ansible azure-cli
```

## Server creation

Login with the `az` utility:

``` bash
az login
```

Create an Azure Service Principal, for Terraform, in Azure Active Directory with the commands:

```
az ad sp create-for-rbac --name="Terraform" --role="Contributor" --scopes="/subscriptions/<subscriptionId>"
```

Create a `terraform.tfvars` file where you will write:

```
vm_admin_username = "YOUR ADMIN USERNAME"
vm_admin_password = "YOUR ADMIN PASSWORD"
```

Other variables that you can set up are:

- `resource_group_name`: The name of the resource group. By default: `MinecraftServer`.
- `vm_size`: The size of the virtual machine. By default: `Standard_B4ms`. Other values can be found [here](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/compute-benchmark-scores).
- `vm_location`: The location of the virtual machine. By default: `westeurope`. Other values can be found [here](https://learn.microsoft.com/en-us/azure/reliability/regions-list)

Run the script `create.sh` to create the server:

``` bash
chmod +x ./create.sh
./create.sh
```

## Server deallocation

To avoid being billed when you don't use the server, run:

``` bash
bash deallocate.sh
```

You will still be billed for the disk. To save money you can:

- Download the world files by connecting via ssh.
- Run `terraform destroy`.

To start up the server again:

- Run `bash create.sh`.
- Place the world files where they were.

The minecraft server is located in `/opt/minecraft`.

## Server restart

To start the server after deallocation, run:

``` bash
bash start.sh
```

## Server deletion

Run:

``` bash
terraform destroy
```

This command requires confirmation, be aware that your world will be lost.

## Changing minecraft version

Open the `playbook.yml` file and set up the variables.

## Changing server settings

Open the `server.properties` file and edit it.