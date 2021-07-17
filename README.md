# Devops & cloud - Caso practico 2

Despliegue de una aplicación en Kubernetes creando una arquitectura cloud en azure

- [Arquitectectura Azure (Terraform)](terraform/Readme.md)
- [Despliegue Kubernetes e instalación de una aplicación (Ansible)](terraform/Readme.md)


 # Primeros pasos
 - Instalar cliente azure
  ```console
  [root@localhost ~]# sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  ...
  [root@localhost ~]# echo -e "[azure-cli]
  name=Azure CLI
  baseurl=https://packages.microsoft.com/yumrepos/azure-cli
  enabled=1
  gpgcheck=1
  gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
  ...
  [root@localhost ~]# sudo dnf install azure-cli
  ```
 
 
 - Login Azure
 ```console
 [root@localhost ~]# az login
 To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code CWEXTYCVC to authenticate.
 ``` 
 
 
 - Instalar git y clonar repo
 ```console
 [root@localhost ~]# sudo dnf install git -y
 ...
 [root@localhost ~]# git clone https://github.com/davidraya-unir/cp2.git
 ```
 
 
 - Instalar Terraform 
 ```console
 [root@localhost ~]# sudo yum install -y yum-utils
 ...
 [root@localhost ~]# sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
 ...
 [root@localhost ~]# sudo yum -y install terraform
 ...
 [root@localhost ~]# terraform -version
 Terraform v1.0.2
 on linux_amd64
 ```

 - Instalar Ansible
