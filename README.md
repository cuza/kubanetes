# Kubanetes

Kubernetes a lo cubano, instalable 馃挴% libre de costo desde la red de ETECSA, basado en [k0s](https://k0sproject.io/) con decisiones y opiniones personales

## Requisitos del sistema

Los requisitos m铆nimos de hardware para k0s que se detallan a continuaci贸n son aproximaciones y, por lo tanto, los
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

## Instalaci贸n

1. Descargue k0s

   Ejecute el script de descarga de k0s para descargar la 煤ltima versi贸n estable de k0s y hacerlo ejecutable en
   /usr/bin/k0s.

    ```shell
    curl -sSLf https://nexus.uclv.edu.cu/repository/github.com/cuza/kubanetes/raw/main/get-k0s | sudo python -
    ```
   
   Si utiliza un servidor proxy en su red puede usar:

   ```shell
   curl -sSLf -x proxy_ip:proxy_puerto https://nexus.uclv.edu.cu/repository/github.com/cuza/kubanetes/raw/main/get-k0s | sudo python -
   ```
   
   Si su sistema operativo usa `python3` en vez de `python` cambie en el comando la version correspondiente


2. Instalar k0s como un servicio

   El subcomando  `k0s install` instala k0s como un servicio del sistema en el host local usando uno de los sistemas
   init compatibles: Systemd u OpenRC. Puede ejecutar la instalaci贸n para instancias workers, controller o
   controller+worker.

   Ejecute el siguiente comando para instalar un solo nodo k0s que incluya las funciones de controller+worker con la
   configuraci贸n predeterminada:

    ```shell
    sudo k0s install controller --single
    ```
3. Inicie el servicio de k0s

   Para iniciar el servicio k0s, ejecute:

    ```shell
    sudo k0s start
    ```

   El servicio k0s se iniciar谩 autom谩ticamente con el host despu茅s del proximo reinicio del nodo.

   Por lo general, pasa uno o dos minutos antes de que el nodo est茅 listo para desplegar aplicaciones.

4. Verifique el servicio, los registros y el estado de k0s

   Para obtener informaci贸n general sobre el estado de su instancia k0s, ejecute:

    ```shell
    $ sudo k0s status
    Version: v0.11.0
    Process ID: 436
    Parent Process ID: 1
    Role: controller+worker
    Init System: linux-systemd
    ```
5. Accede a tu cl煤ster usando kubectl

   **Nota:** k0s incluye la herramienta de l铆nea de comandos de Kubernetes kubectl

   Use kubectl para desplegar su aplicaci贸n o para verificar el estado de su nodo:

    ```shell
    $ sudo k0s kubectl get nodes
    NAME   STATUS   ROLES    AGE    VERSION
    k0s    Ready    <none>   4m6s   v1.21.3-k0s1
    ```

6. (Opcional) Expandiendo el cluster
   1. Como agregar nuevos workers
      
      Necesitas un token para unir nodos al cl煤ster. El token incorpora informaci贸n que permite la confianza mutua entre los nuevos nodos y los controladores y permite que este se una al cl煤ster.

      Para obtener un token, ejecute el siguiente comando en uno de los nodos de controlador existentes:

      ```shell
      k0s token create --role=worker
      ```
      La salida resultante es una cadena de token larga , que puede usar para agregar un trabajador al cl煤ster.

      Para mayor seguridad, ejecute el siguiente comando para establecer una fecha de vencimiento para el token:

      ```shell
      k0s token create --role=worker --expiry=100h > token-file
      ```
      Para unirse al cluster con el nuevo nodo, ejecute k0s en el modo de worker con el token que cre贸:
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

      Si desea crear un nodo controller+worker en el nuevo nodo, ejecute:

      ```shell
      sudo k0s install controller --enable-worker --token-file /path/to/token/file --single
      k0s start
      ```

## Documentaci贸n

Este proyecto es un instalador que de [k0s](https://k0sproject.io/) que utiliza recursos publicados por la [UCLV](https://www.uclv.edu.cu/) libres de costo. Si desea profundizar mas en la instalaci贸n o configuraci贸n del cluster visite la [documentacion oficial](https://docs.k0sproject.io/main/install)
