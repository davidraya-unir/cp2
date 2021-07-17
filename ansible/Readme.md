# Ansible

- Obtenemos las ips de las maquinas creadas en Azure
```console
[root@localhost cp2]# az vm show -d -g kubernetes_rg -n master01-vm --query publicIps -o tsv
20.105.158.73
...
[root@localhost cp2]# az vm show -d -g kubernetes_rg -n worker01-vm --query publicIps -o tsv
20.86.122.192
...
```

- Configuramos el host de la máquina controller de Ansible con las ips creadas en azure
```console
[root@localhost cp2]# vi /etc/hosts
...
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
20.105.158.73 master.azure nfs.azure
20.86.122.192 worker.azure
```

- Modificamos de configuración de Ansible [group_vars/config.yaml](group_vars/config.yaml) con las ips correspondientes
```console
timezone: 'Europe/Madrid'
ips_exports_nfs: ['192.168.1.51', '192.168.1.52']
kubernetes_nodes: [
  {ip: '192.168.1.51', dns: 'master.local', type: 'master'},
  {ip: '192.168.1.52', dns: 'worker.local', type: 'worker'},
  {ip: '192.168.1.51', dns: 'nfs.local', type: 'nfs'}
]
server: 'local' # local o azure
```

