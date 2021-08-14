# Kubanetes

Kubernetes a lo cubano, instalable 💯% libre de costo desde la red de ETECSA, basado en k0s con decisiones y opiniones personales

## Requisitos del sistema

Los requisitos mínimos de hardware para k0 que se detallan a continuación son aproximaciones y, por lo tanto, los
resultados pueden variar.

| Rol                 | Virtual CPU (vCPU)     | Memoria (RAM)          |
|---------------------|------------------------|------------------------|
| Nodo Controller     | 1 vCPU (2 recomendado) | 1 GB (2 recomendado)   |
| Nodo Worker         | 1 vCPU (2 recomendado) | 0.5 GB (1 recomendado) |
| Controller + Worker | 1 vCPU (2 recomendado) | 1 GB (2 recomendado)   |

### Host

- Linux (kernel v3.10 o posterior)
- Python 2.7 o superior

### Arquitectura

- x86-64
- ARM64
- ARMv7

## Instalación

1. Descargue k0s

   Ejecute el script de descarga de k0s para descargar la última versión estable de k0s y hacerlo ejecutable en
   /usr/bin/k0s.

    ```shell
    curl -sSLf https://nexus.uclv.edu.cu/repository/github.com/cuza/kubanetes/raw/main/get-k0s | sudo python
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

   El servicio k0s se iniciará automáticamente con el host después del proximo reinicio del nodo.

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

6. (Opcional) Expandiendo el cluster
   1. Como agregar nuevos workers
      
      Necesitas un token para unir nodos al clúster. El token incorpora información que permite la confianza mutua entre los nuevos nodos y los controladores y permite que este se una al clúster.

      Para obtener un token, ejecute el siguiente comando en uno de los nodos de controlador existentes:

      ```shell
      k0s token create --role=worker
      ```
      La salida resultante es una cadena de token larga , que puede usar para agregar un trabajador al clúster.

      Para mayor seguridad, ejecute el siguiente comando para establecer una fecha de vencimiento para el token:

      ```shell
      k0s token create --role=worker --expiry=100h > token-file
      ```
      Para unirse al cluster con el nuevo nodo, ejecute k0s en el modo de worker con el token que creó:
      ```shell
      sudo k0s install worker --token-file /path/to/token/file
      sudo k0s start
      ```
   2. Como agregar nuevos controllers
      
      Para crear un token para el nuevo controlador, ejecute el siguiente comando en un controlador existente:

      ```shell
      k0s token create --role=controller --expiry=1h > token-file
      ```

      En el nuevo controlador, ejecute:

      ```shell
      sudo k0s install controller --token-file /path/to/token/file
      k0s start
      ```


