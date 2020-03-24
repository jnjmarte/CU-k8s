# Despliegue de un cluster de Kubernetes 1.16 sobre CentOS 7 usando Vagrant y VirtualBox
>Proyecto creado para la asignatura **Computación ubicua, móvil y en la nube** del Grado en Tecnologías para la Sociedad de la Información de la ETSISI de la UPM.

## Requisitos
* **VirtualBox** - Probado con la versión 6.1
* **Vagrant** - Probado con la versión 2.2.7
* **vagrant-hostmanager** plugin - Probado con la versión 1.8.9
```
    vagrant plugin install vagrant-hostmanager
```

## Máquinas virtuales desplegadas
Se despliegan en total 5 máquinas virtuales (nodos): 2 master y 3 worker, y se instala etcd en 3 de ellos para asegurar la alta disponibilidad del mismo.

El detalle de las MVs que se instalarán es:

* (2x) masters
    * cpu: 1
    * memory: 2000
    * disks:
        * sda: 40 Gb
        * sdb: 20 Gb

* (3x) workers
    * cpu: 1
    * memory: 1500
    * disks:
        * sda: 40 Gb
        * sdb: 20 Gb


## Diagrama

![GitHub Logo](/images/Entorno.png)


## Notas

* El almacenamiento se asigna dinámicamente, así que no se ocupará inicialmente todo el espacio de disco indicado antes.
* Es necesario que los hostnames se resuelvan por un servidor DNS. Ya que es un entorno de pruebas, en vez de configurar uno con la complejidad que añadiría, usaremos [xip.io](http://xip.io) de Basecamp que nos proporcionará funcionalidad wildcard DNS para nuestro entorno.

## INSTALACIÓN
### Clonar el proyecto y crear la infraestructura
```
git clone https://github.com/fmaderuelo/CU-k8s.git
cd CU-k8s
vagrant up
```
### Conectarse al bastión (master-1) y preparar los nodos
```
vagrant ssh master-1
sudo su
cd /root/kubespray_installation/
ansible-playbook -i inventories/bastion playbooks/prepare_bastion.yaml 
ansible-playbook -i /root/kubespray/inventory/mycluster/inventory.ini playbooks/prepare_nodes.yaml 

```
### Instalar Kubernetes
```
cd /root/kubespray/
pip install --user -r requirements.txt
ansible-playbook -i /root/kubespray/inventory/mycluster/inventory.ini cluster.yml
```
### Configurar nuestro usuario para usar kubectl y alias
Por defecto el usuario configurado es **vagrant** con password **vagrant**. Podemos usar ese o crear uno propio y modificar o borrar el anterior.
Para poder usar el comando **kubectl** y el alias **kc** correctamente con nuestro usuario ejecutamos el siguiente script desde una shell del usuario a configurar (necesitará permiso para usar *sudo*):
```
sh /opt/postinstall.sh
```
Si en vez de usar el alias **kc** queremos usar otro personalizado podemos modificarlo en $HOME/.bashrc
Este alias se ha configurado para que autocomplete usando el tabulador.

Podemos probar con algunos comandos para ver que todo funciona como debería:
```
source ~/.bashrc
kubectl get nodes
kc get pods --all-namespaces
kc cluster-info
```