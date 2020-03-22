# Despliegue de un cluster de Kubernetes 1.16 sobre CentOS 7 usando Vagrant y VirtualBox

## Requisitos
* **VirtualBox** - Probado con la versión 6.1
* **Vagrant** - Probado con la versión 2.2.7
* **vagrant-hostmanager** plugin - Probado con la versión 1.8.9

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

> Nota: *El almacenamiento se asigna dinámicamente, así que no se ocupará inicialmente todo ese espacio en disco.*
