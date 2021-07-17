# Terraform

- Crear service principal
```console
[root@localhost ~]# az account set --subscription="fecde38a-1a40-4194-901a-861b021e88ef"
...
[root@localhost ~]# az ad sp create-for-rbac --role="Contributor"
```

