# Despliegue de un cluster de Kubernetes 1.16 sobre CentOS 7 usando Vagrant y VirtualBox
*Proyecto creado para la asignatura **Computación ubícua, móvil y en la nube** del Grado en Tecnologías para la Sociedad de la Información de la ETSISI de la UPM.*

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


## Diagrama

![GitHub Logo](/images/Entorno.png)


## Notas

* El almacenamiento se asigna dinámicamente, así que no se ocupará inicialmente todo ese espacio en disco.
* Es necesario que los hostnames se resuelvan por un servidor DNS. Ya que es un entorno de pruebas, en vez de configurar uno con la complejidad que añadiría, usaremos [xip.io](http://xip.io) de Basecamp que nos proporcionará funcionalidad wildcard DNS para nuestro entorno.

## Instalación
### Clonar el proyecto y crear la infraestructura
```
git clone https://github.com/fmaderuelo/CU-k8s.git
cd CU-k8s
vagrant up
```




