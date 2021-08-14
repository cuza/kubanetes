# Kubanetes

Kubernetes a lo cubano, basado en k0s con decisiones y opiniones personales

## Requisitos del sistema

Los requisitos mínimos de hardware para k0 que se detallan a continuación son aproximaciones y, por lo tanto, los
resultados pueden variar.

| Rol                 | Virtual CPU (vCPU)     | Memoria (RAM)          |
|---------------------|------------------------|------------------------|
| Nodo Controller     | 1 vCPU (2 recomendado) | 1 GB (2 recomendado)   |
| Nodo Worker         | 1 vCPU (2 recomendado) | 0.5 GB (1 recomendado) |
| Controller + worker | 1 vCPU (2 recomendado) | 1 GB (2 recomendado)   |

### Sistema operativo

- Linux (kernel v3.10 o posterior)

### Arquitectura

- x86-64
- ARM64
- ARMv7

## Instalación

1. Descargue k0s

   Ejecute el script de descarga de k0s para descargar la última versión estable de k0s y hacerlo ejecutable en
   /usr/bin/k0s.

    ```shell
    curl -sSLf https://nexus.uclv.edu.cu/repository/github.com/cuza/kubanetes/raw/main/get-k0s | sudo sh
    ```
2. Instalar k0s como un servicio

   El subcomando  `k0s install` instala k0s como un servicio del sistema en el host local usando uno de los sistemas
   init compatibles: Systemd u OpenRC. Puede ejecutar la instalación para instancias workers, controller o
   controller+worker.

   Ejecute el siguiente comando para instalar un solo nodo k0s que incluya las funciones de controller+worker con la
   configuración predeterminada:

    ```shell
    sudo k0s install controller --single
    ```
3. Inicie el servicio de k0s

   Para iniciar el servicio k0s, ejecute:

    ```shell
    sudo k0s start
    ```

   El servicio k0s se iniciará automáticamente en el host después del reinicio del nodo.

   Por lo general, pasa uno o dos minutos antes de que el nodo esté listo para desplegar aplicaciones.

4. Verifique el servicio, los registros y el estado de k0s

   Para obtener información general sobre el estado de su instancia k0s, ejecute:

    ```shell
    $ sudo k0s status
    Version: v0.11.0
    Process ID: 436
    Parent Process ID: 1
    Role: controller+worker
    Init System: linux-systemd
    ```
5. Accede a tu clúster usando kubectl

   **Nota:** k0s incluye la herramienta de línea de comandos de Kubernetes kubectl

   Use kubectl para desplegar su aplicación o para verificar el estado de su nodo:

    ```shell
    $ sudo k0s kubectl get nodes
    NAME   STATUS   ROLES    AGE    VERSION
    k0s    Ready    <none>   4m6s   v1.21.3-k0s1
    ```

