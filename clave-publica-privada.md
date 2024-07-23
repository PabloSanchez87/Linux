
# Criptografía Asimétrica y Claves Pública-Privada

## Criptografía Asimétrica

La criptografía asimétrica es un tipo de criptografía que utiliza un par de claves para cifrar y descifrar datos. Este par de claves consta de una **clave pública** y una **clave privada**. A diferencia de la criptografía simétrica, donde se usa la misma clave para cifrar y descifrar, en la criptografía asimétrica las claves son diferentes pero están matemáticamente relacionadas.

### Características

- **Clave Pública**
    - Se puede compartir libremente y se utiliza para cifrar datos o verificar una firma digital.
- **Clave Privada**
    - Se mantiene en secreto y se utiliza para descifrar datos o crear una firma digital.

### Ejemplo de Uso

1. **Cifrado de Datos**
    - Una persona puede cifrar un mensaje con la clave pública del destinatario. Solo el destinatario, con su clave privada, puede descifrarlo.
2. **Firmas Digitales**
    - Una persona puede firmar un documento con su clave privada. Cualquiera puede verificar la firma usando la clave pública de esa persona.

## Generación de Claves

La generación de claves pública y privada se realiza utilizando algoritmos específicos como RSA, DSA o ECDSA. Un ejemplo común de generación de claves usando `ssh-keygen` en sistemas Unix/Linux:

```sh
ssh-keygen -t rsa -b 4096 -C "tu_email@example.com"
```

Esto crea un par de claves:

- `~/.ssh/id_rsa`: La clave privada.
- `~/.ssh/id_rsa.pub`: La clave pública.

## `authorized_keys`

El archivo `authorized_keys` se utiliza en servidores SSH para controlar el acceso mediante claves públicas. Cuando un usuario intenta conectarse al servidor, el servidor verifica si la clave pública proporcionada por el usuario está en el archivo `~/.ssh/authorized_keys`.

### Configuración

1. **Copiar la clave pública al servidor**:
   - Manualmente:
     ```sh
     cat ~/.ssh/id_rsa.pub | ssh usuario@servidor "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
     ```
   - Usando `ssh-copy-id`:
     ```sh
     ssh-copy-id usuario@servidor
     ```

2. **Verificación**
    - El servidor SSH verifica la clave pública en el archivo `authorized_keys` y permite el acceso si la clave coincide.

## `scp` (Secure Copy Protocol)

`scp` es una herramienta para transferir archivos entre un host local y un host remoto o entre dos hosts remotos de manera segura usando el protocolo SSH.

### Uso Básico

- **Copiar un archivo del local al remoto**:
  ```sh
  scp archivo_local usuario@servidor:/ruta/remota
  ```

- **Copiar un archivo del remoto al local**:
  ```sh
  scp usuario@servidor:/ruta/remota/archivo_local .
  ```

- **Copiar un directorio recursivamente**:
  ```sh
  scp -r directorio_local usuario@servidor:/ruta/remota
  ```

### Opciones Comunes

- `-r`: Copia recursivamente todos los archivos y directorios.
- `-P`: Especifica el puerto SSH si no es el puerto predeterminado (22).
- `-C`: Habilita la compresión para la transferencia de archivos.

## Consideraciones de Seguridad

- **Clave Privada** 
    - Nunca compartas tu clave privada. Manténla segura y protegida.
- **Frase de Paso** 
    - Al generar las claves, se recomienda utilizar una frase de paso para añadir una capa extra de seguridad.
- **Permisos**
    - Asegúrate de que los permisos del archivo `authorized_keys` sean correctos (usualmente `600`).


## `ssh-copy-id`

`ssh-copy-id` es una herramienta utilizada para instalar una clave SSH pública en un servidor remoto para la autenticación sin contraseña. Esto facilita la configuración inicial de acceso SSH seguro.

### Uso Básico

- **Copiar la clave pública al servidor**:
  ```sh
  ssh-copy-id usuario@servidor
  ```

- **Copiar una clave pública específica**:
  ```sh
  ssh-copy-id -i ~/.ssh/mi_clave_rsa.pub usuario@servidor
  ```

### Permisos Recomendados

- Permisos `~/.ssh`: 700
- `~/.ssh/authorized_keys`: 600

## `rsync`

`rsync` es una herramienta de línea de comandos en sistemas basados en Unix y Linux utilizada para la copia y sincronización de archivos y directorios de manera eficiente, tanto localmente como de forma remota entre dos máquinas.

### Características Principales

- **Transferencia Diferencial**
    - Solo envía las diferencias entre los archivos de origen y los archivos existentes en el destino.
- **Compresión**
    - Reduce el tamaño de los datos durante la transferencia usando compresión.
- **Simulación**
    - Permite realizar una simulación de la ejecución sin hacer cambios reales.

### Uso Básico

- **Copiar un directorio local a un servidor remoto**:
  ```sh
  rsync -avz /ruta/local/ usuario@host_remoto:/ruta/destino/
  ```

- **Opciones Comunes**:
  - `-a, --archive`
    - Activa múltiples opciones simultáneamente, como la recursividad, la preservación de enlaces simbólicos, permisos de archivo, tiempos de modificación, propietarios de archivos y grupos.
  - `-v, --verbose`
    - Muestra detalles adicionales durante la transferencia.
  - `-z, --compress`
    - Usa compresión para reducir el tamaño de los datos transferidos.
  - `-r, --recursive`
    - Copia directorios de manera recursiva.
  - `--delete`
    - Elimina archivos en el directorio de destino que no están presentes en el directorio de origen.
  - `-h, --human-readable`
    - Muestra las cifras de los tamaños de archivo en un formato más legible.
  - `-n, --dry-run`
    - Realiza una simulación de la ejecución de `rsync` sin hacer cambios reales.
  - `--progress`
    - Muestra el progreso de la transferencia de archivos.
  - `-e, --rsh=COMMAND`
    - Permite especificar un comando de shell remoto, como ssh.
  - `--exclude=PATTERN`
    - Excluye archivos que coincidan con el patrón especificado.
  - `--backup`
    - Hace una copia de respaldo de cada archivo que se va a sobrescribir o eliminar.

---

## Ejemplos y casos de uso.
### Sincronizar un directorio local con un directorio en un servidor remoto
- Sincronizar todos los archivos y directorios desde un directorio local a un directorio en un servidor remoto utilizando `rsync`
    ```bash
    rsync -avz /local/directorio/ usuario@servidor:/remoto/directorio/
    ```
    - `-a, --archive`
        - Activa el modo de archivo, que incluye la recursividad y la preservación de permisos, enlaces simbólicos, tiempos de modificación, propietarios y grupos.
    - `-v, --verbose`
        - Muestra detalles adicionales durante la transferencia.
    - `-z, --compress` 
        - Usa compresión para reducir el tamaño de los datos transferidos.

---

### Sincronizar un directorio de un servidor remoto a un directorio local
- Sincronización en la dirección opuesta, desde un directorio en un servidor remoto a un directorio local.
    ```bash
    rsync -avz usuario@servidor:/remoto/directorio/ /local/directorio/
    ```

---

### Realizar una copia de seguridad local de un directorio, excluyendo algunos subdirectorios o archivos
- Cómo excluir ciertos directorios o archivos durante la sincronización utilizando la opción `--exclude`.
    ```bash
    rsync -avz --exclude 'temp/' --exclude 'backups/' /local/origen/ /local/destino/
    ```
    - `--exclude 'temp/'`
        - Excluye el directorio temp/.
    - `--exclude 'backups/'`
        -  Excluye el directorio backups/.

---

### Simular una operación de sincronización sin realizar cambios (dry run)
- Permite ver qué cambios haría `rsync` sin realmente realizar ninguna transferencia de archivos, usando la opción `-n`.
    ```bash
    rsync -avzn /local/origen/ /local/destino/
    ```
    - `-n, --dry-run`
        - Realiza una simulación de la ejecución de `rsync` sin hacer cambios reales.

---

### Transferir archivos específicos de un directorio local a un servidor remoto
- Cómo sincronizar archivos específicos, excluyendo todos los demás.
    ```bash
    rsync -avz /local/directorio/archivo1.txt /local/directorio/archivo2.jpg usuario@servidor:/remoto/directorio/
    ```
