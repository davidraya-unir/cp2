# Devops & cloud - Caso practico 2

Despliegue de una aplicación en Kubernetes creando una arquitectura cloud en azure

- [Arquitectectura Azure (Terraform)](terraform/Readme.md)
- [Despliegue Kubernetes e instalación de una aplicación (Ansible)](terraform/Readme.md)


> # Primeros pasos
> - Instalar cliente azure
>  ```console
>  [root@localhost ~]# sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
>  ...
>  [root@localhost ~]# echo -e "[azure-cli]
>  name=Azure CLI
>  baseurl=https://packages.microsoft.com/yumrepos/azure-cli
>  enabled=1
>  gpgcheck=1
>  gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
>  ...
>  [root@localhost ~]# sudo dnf install azure-cli
>  ```
