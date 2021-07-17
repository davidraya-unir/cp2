# Devops & cloud - Caso practico 2

Despliegue de una aplicación en Kubernetes creando una arquitectura cloud en azure

- [Arquitectectura Azure (Terraform)](terraform/Readme.md)
- [Despliegue Kubernetes e instalación de una aplicación (Ansible)](ansible/Readme.md)


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
____________________________________________________________________________________________________________________________________________________________
 
 - Login Azure
 ```console
 [root@localhost ~]# az login
 To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code CWEXTYCVC to authenticate.
 ``` 
____________________________________________________________________________________________________________________________________________________________ 
 
 - Instalar git y clonar repo
 ```console
 [root@localhost ~]# sudo dnf install git -y
 ...
 [root@localhost ~]# git --version
 git version 2.27.0
 ...
 [root@localhost ~]# git clone https://github.com/davidraya-unir/cp2.git
 ```
____________________________________________________________________________________________________________________________________________________________
 
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
 ____________________________________________________________________________________________________________________________________________________________
 
 - Instalar Ansible
 ```console
 [root@localhost ~]# yum install epel-release
 ...
 [root@localhost ~]# yum install ansible
 ...
 [root@localhost ~]# ansible --version
 ansible 2.9.23
   config file = /etc/ansible/ansible.cfg
   configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
   ansible python module location = /usr/lib/python3.6/site-packages/ansible
   executable location = /usr/bin/ansible
   python version = 3.6.8 (default, Mar 19 2021, 05:13:41) [GCC 8.4.1 20200928 (Red Hat 8.4.1-1)]
 ```
