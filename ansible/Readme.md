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
# Ejecución de los playbooks

- Configuración inicial de entornos

Realiza la actulazación de paquetes, configuración de la zona horaria y deshabilita SELinux

```console
[root@localhost ansible]# ansible-playbook -i hosts 01-config-init.yaml

PLAY [config environments] **********************************************************************************************

TASK [install-packages : include_tasks] *********************************************************************************
included: /root/cp2/ansible/roles/install-packages/tasks/01-dnf-update.yaml for master.azure, worker.azure

TASK [install-packages : update dnf] ************************************************************************************
......
PLAY RECAP **************************************************************************************************************
master.azure               : ok=12   changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
worker.azure               : ok=12   changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

- Configuración del NFS

Realiza la configuración del NFS (Creación del volumne group, logical volume, asignación de permisos al resto de máquinas, etc)

```console
[root@localhost ansible]# ansible-playbook -i hosts 02-config-nfs.yaml

PLAY [create nfs] *******************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************
ok: [nfs.azure]

TASK [nfs : include_tasks] **********************************************************************************************
included: /root/cp2/ansible/roles/nfs/tasks/01-create-volumegroup.yaml for nfs.azure
....
TASK [nfs : reload service firewalld] ***********************************************************************************
changed: [nfs.azure]

PLAY RECAP **************************************************************************************************************
nfs.azure                  : ok=19   changed=12   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

- Instalación y configuración de kubernetes 

Realiza toda la configuración e instalación de Docker y Kubernetes en los nodos Workers y Master

```console
[root@localhost ansible]# ansible-playbook -i hosts 03-config-kubernetes.yaml

PLAY [config environments] **********************************************************************************************

TASK [dns : include_tasks] **********************************************************************************************
included: /root/cp2/ansible/roles/dns/tasks/01-config-hosts.yaml for master.azure, worker.azure
...
TASK [kbt-worker-config : execute command kubeadm join] *****************************************************************
changed: [worker.azure]

PLAY RECAP **************************************************************************************************************
master.azure               : ok=38   changed=26   unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
worker.azure               : ok=26   changed=17   unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```

- Instalación de una aplicación en Kubernetes (RabbitMq)

```console
[root@localhost ansible]# ansible-playbook -i hosts 04-install-rabbit.yaml

PLAY [Install rabbit] ***************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************
ok: [master.azure]
....
TASK [rabbit-install : Redirect port for manage portal] *****************************************************************
changed: [master.azure]

PLAY RECAP **************************************************************************************************************
master.azure               : ok=14   changed=10   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

# Validación de instalación

Para comprobar que toda la instalacion ha funcionado correctamente, accedemos al portal de administración que rabbitmq expone a través del puerto 15672

http://20.105.158.73:15672

Los datos de acceso de la instalación por defecto son

Usuario: guest
Contraseña: guest
