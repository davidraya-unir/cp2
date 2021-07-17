# Terraform

- Crear service principal
```console
[root@localhost ~]# az account set --subscription="fecde38a-1a40-4194-901a-861b021e88ef"
...
[root@localhost ~]# az ad sp create-for-rbac --role="Contributor"
```
____________________________________________________________________________________________________________________________________________


- Crear credentials.tf
> Para ello sustituimos las variables <> por el resultado obtenido al crear el sercice principal

> ```console
> provider "azurerm" {
> 	features {}
> 	subscription_id = "<SUBSCRIPTION_ID>"
> 	client_id 		= "<appId>"
> 	client_secret 	= "<password>"
> 	tenant_id 		= "<tenand>"
> }
> ```
____________________________________________________________________________________________________________________________________________

- Crear clave publica
```console
[root@localhost terraform]# ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Created directory '/root/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:PUGn5iMoynNxtSuF1EMKC26Pfyt3Aa1JrUFzSb2YeCY root@localhost.localdomain
The key's randomart image is:
+---[RSA 3072]----+
|  . .  .oo. .    |
| . . oo+o..o     |
|  o ..o*+o+.     |
| . o .E+B*..     |
|  . +.+XS =      |
| . o ++..o o     |
|  + o o ..       |
|   o...o.        |
|     o..         |
+----[SHA256]-----+
```

Actualizamos la ruta de la clave en el fichero correcion-vars.tf
  
```console
variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "West Europe" 
}

variable "storage_account" {
  type = string
  description = "Nombre para la storage account"
  default = "staccountcp2draya"
}

variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default = "/root/.ssh/id_rsa.pub" # o la ruta correspondiente
}

variable "ssh_user" {
  type = string
  description = "Usuario para hacer ssh"
  default = "adminUsername"
}
```
____________________________________________________________________________________________________________________________________________

- Inicializamos terrraform
```console 
[root@localhost terraform]# terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/azurerm from the dependency lock file
- Installing hashicorp/azurerm v2.46.1...
```
____________________________________________________________________________________________________________________________________________  

- Ejecutar plan
```console
[root@localhost terraform]# terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_linux_virtual_machine.myVM1[0] will be created
  + resource "azurerm_linux_virtual_machine" "myVM1" {
      + admin_username                  = "adminUsername"
      + allow_extension_operations      = true
      + computer_name                   = (known after apply)
....
```

____________________________________________________________________________________________________________________________________________  
- Aplicamos el plan
```console
[root@localhost terraform]# terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_linux_virtual_machine.myVM1[0] will be created
  + resource "azurerm_linux_virtual_machine" "myVM1" {
...
...
azurerm_linux_virtual_machine.myVM1[1]: Still creating... [2m50s elapsed]
azurerm_linux_virtual_machine.myVM1[1]: Creation complete after 2m55s [id=/subscriptions/fecde38a-1a40-4194-901a-**********/resourceGroups/kubernetes_rg/providers/Microsoft.Compute/virtualMachines/worker01-vm]

Apply complete! Resources: 14 added, 0 changed, 0 destroyed.
[root@localhost terraform]#
```

____________________________________________________________________________________________________________________________________________  
