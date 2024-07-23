# Servidor SSH
- El **servidor SSH (Secure Shell)** es una herramienta fundamental en Unix y Linux que permite la administración remota segura de sistemas y la transferencia de archivos de manera cifrada. 

- [Documentación externa: Explicación detallada de cómo funciona SSH](https://www.hostinger.es/tutoriales/que-es-ssh)

## ¿Qué es SSH?
- **SSH (Secure Shell)** es un protocolo de red criptográfico para operar servicios de red de manera segura sobre una red no segura. 
- **SSH** proporciona un canal seguro sobre una red insegura en una arquitectura `cliente-servidor`, conectando una aplicación `cliente SSH` con un `servidor SSH`.

## Funcionalidades de SSH
- **Acceso remoto**: 
    - Permite a los usuarios iniciar sesión en un servidor remoto y ejecutar comandos.
- **Transferencia de archivos**: 
    - Proporciona mecanismos seguros para transferir archivos entre el cliente y el servidor (usando herramientas como scp y sftp).
- **Túneles seguros**: 
    - Permite el redireccionamiento de puertos y la creación de túneles cifrados para asegurar el tráfico de aplicaciones.

## Configuración de un Servidor SSH en Unix/Linux
`1. Instalación del servidor SSH`
- La mayoría de las distribuciones Unix/Linux incluyen OpenSSH, un conjunto de herramientas SSH que incluye el servidor SSH (sshd). 
- En sistemas basados en **Debian** (como Ubuntu), puedes instalar OpenSSH con:
    ```bash
    sudo apt update
    sudo apt install openssh-server
    ```
- En sistemas basados en **Red Hat** (como CentOS y Fedora), puedes instalarlo con:
    ```bash
    sudo yum install openssh-server
    ```

`2. Configuración del servidor SSH`

- El archivo principal de configuración del servidor SSH es /`etc/ssh/sshd_config`. 
- Puedes editar este archivo para ajustar la configuración del servidor.
- Ejemplo de algunos parámetros importantes en `sshd_config`:
    - **Puerto (Port)**: 
        - Define el puerto en el que el servidor SSH escucha (por defecto es el 22).
    - **PermitRootLogin**: 
        - Controla si el usuario root puede iniciar sesión directamente.
    - **PasswordAuthentication**: 
        - Permite o deniega la autenticación mediante contraseña.
    - **PubkeyAuthentication**: 
        - Permite la autenticación mediante clave pública.
- Para editar el archivo, usa un editor de texto como nano o vim:
    ```bash 
    sudo nano /etc/ssh/sshd_config
    ```
- Ejemplo de configuracion básica:
    ```text
    Port 22
    PermitRootLogin no
    PasswordAuthentication yes
    PubkeyAuthentication yes
    ```

`3. Iniciar y habilitar el servicio SSH`

- Después de configurar el servidor, inicia el servicio SSH y asegúrate de que se inicie automáticamente al arrancar el sistema.
- En sistemas basados en Debian/Ubuntu:
    ``` bash
    sudo systemctl start ssh
    sudo systemctl enable ssh
    ```
- En sistemas basados en Red Hat/CentOS:
    ```bash
    sudo systemctl start sshd
    sudo systemctl enable sshd
    ```

## Uso del Cliente SSH
- Para conectarte a un servidor SSH, puedes usar el comando ssh desde la terminal.
- Sintaxis básica:
    ```bash
    ssh usuario@servidor

    #Ejemplo
    ssh -p 2222 -i ~/.ssh/id_rsa juan@192.168.1.10
    ```
    - Opciones comunes:
        - `-p`: Especifica un puerto diferente al predeterminado (22).
        - `-i`: Especifica un archivo de clave privada para la autenticación.

## Transferencia de archivos con SCP y SFTP
- `SCP (Secure Copy)`
    - Permite copiar archivos de manera segura entre un cliente y un servidor.
    - Ejemplo de copiar un archivo del cliente al servidor
        ```bash
        scp archivo.txt usuario@servidor:/ruta/remota/
        ```
- `SFTP (SSH File Transfer Protocol)`
    - Proporciona una sesión interactiva para transferir archivos.
    - Ejemplo de uso
        ```bash
        sftp usuario@servidor
        sftp> put archivo.txt
        sftp> get archivo.txt
        ```

## Seguridad en SSH
- Para mejorar la seguridad del servidor SSH, considera las siguientes prácticas
    - **Deshabilitar el acceso root**
        - Evita que el usuario root inicie sesión directamente. Usa PermitRootLogin no en sshd_config.
    - **Usar autenticación por clave pública**
        - En lugar de contraseñas, usa pares de claves públicas y privadas para la autenticación.
    - **Cambiar el puerto predeterminado**
        - Usa un puerto diferente al 22 para reducir la cantidad de intentos de intrusión automatizados.
    - **Configurar un firewall**
        - Usa iptables o ufw para permitir solo las conexiones necesarias.
    - **Monitorizar el servidor**
        - Utiliza herramientas como fail2ban para proteger contra ataques de fuerza bruta.

### Ejemplo de Configuración de autentificación por Clave pública.
**1. Generar un par de claves en el cliente**

```bash
ssh-keygen -t rsa -b 4096 -C "tu_email@example.com"
```
    
- Esto generará una `clave pública (~/.ssh/id_rsa.pub)` 
- Y una `clave privada (~/.ssh/id_rsa)`


**2. Copiar la clave pública al servidor**

```bash
ssh-copy-id usuario@servidor
```

- O manualmente

```bash
cat ~/.ssh/id_rsa.pub | ssh usuario@servidor 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
```

**3. Conectarse al servidor usando la clave**

```bash
ssh usuario@servidor
```


