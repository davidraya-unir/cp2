# Ansible

- Configuramos el fichero host de la maquina controller con las ips creadas en azure
```console
[root@localhost ansible]# vi /etc/hosts
...
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
20.86.177.220 master.azure nfs.azure
20.93.138.85  worker.azure
```

- Creamos el usuario ansible en las maquinas de azure
```console
[root@localhost ansible]# ssh adminUsername@master.azure
...
[adminUsername@master01-vm ~]$ sudo useradd -md /home/ansible ansible
[adminUsername@master01-vm ~]$ sudo passwd ansible
```
y asignamos permisos

```console
[adminUsername@worker01-vm ~]$ sudo vi /etc/sudoers.d/ansible
...
ansible ALL=(ALL) NOPASSWD:ALL
```
Realizar la creación de usuarios en todas las maquinas
