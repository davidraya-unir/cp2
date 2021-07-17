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
