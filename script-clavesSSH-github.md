# Guía de Uso del Script 

## Introducción
- Este script automatiza la generación y configuración de claves SSH para autenticarte en GitHub. 
- Además, configura Git con tu nombre de usuario y correo electrónico.

## Funcionamiento del Script
El script realiza las siguientes acciones:

- **Verificación de Claves SSH Existentes** 
    - Comprueba si ya existen claves SSH en tu sistema para evitar sobrescribirlas.
- **Generación de Claves SSH** 
    - Crea un nuevo par de claves SSH si no existen previamente.
- **Añadir Clave SSH al Agente** 
    - Añade la clave SSH recién generada al agente SSH para gestionar las claves.
- **Mostrar Clave Pública** 
    - Muestra la clave pública generada para que puedas añadirla a tu cuenta de GitHub.
- **Verificación de Clave SSH en GitHub** 
    - Verifica que la clave SSH se ha añadido correctamente a tu cuenta de GitHub.
- **Configuración de Git** 
    - Configura Git con tu nombre de usuario y correo electrónico de GitHub.

## Uso del Script

1. **Paso 1: Configuración Inicial**

    - **Edita el script**
        - Abre el script en tu editor de texto favorito y modifica las siguientes variables con tu información:
            ```bash
            EMAIL="tu_email@example.com"
            GITHUB_USERNAME="tu_usuario_github"
            ```

2. **Paso 2: Ejecución del Script**
    - **Haz el script ejecutable**
        ```bash
        chmod +x script-clavesSSH-github.sh
        ```
    - **Ejecuta el script**
        ```bash
        ./script-clavesSSH-github.sh
        ```

3. **Paso 3: Añadir la Clave Pública a GitHub**
    - **Copia la clave pública:** 
        -El script mostrará tu clave pública, cópiala.
    - **Añadir clave a GitHub** 
        - Ve a GitHub SSH keys y añade una nueva clave SSH pegando la clave pública copiada.

4. **Paso 4: Confirmar la Adición de la Clave**
    - **Presiona Enter** 
        - Después de añadir la clave pública a GitHub, vuelve al terminal y presiona Enter para que el script continúe.
    - **Verificación** 
        - El script intentará autenticarse con GitHub para verificar que la clave se ha añadido correctamente.

5. **Paso 5: Configuración de Git**
    - **Configuración automática** 
        - El script configurará Git con tu nombre de usuario y correo electrónico proporcionados al inicio del script.

## Nota importante
 - El **script requiere interacción manual para agregar la clave SSH a GitHub**, ya que GitHub no permite la automatización de este proceso por razones de seguridad. 
 - Durante la ejecución, el script te mostrará la clave pública y te pedirá que la agregues manualmente a tu cuenta de GitHub siguiendo estos pasos: 
    - Ve a [GitHub - SSH and GPG keys](https://github.com/settings/keys).
    - Haz clic en **"New SSH key"**.
    - Pega la **clave pública** que te proporciona el script y dale un nombre.
    - Guarda la clave.
- Una vez que la clave esté añadida, puedes continuar con la ejecución del script.

## Borrar las Claves SSH Generadas en Caso de Error
- Si ocurre un error durante la ejecución del script y necesitas borrar las claves SSH generadas, usa los siguientes comandos:
    ```bash
    # Listar claves SSH en el agente
    ssh-add -l

    # Borrar la clave privada SSH
    rm -f ~/.ssh/id_rsa

    # Borrar la clave pública SSH
    rm -f ~/.ssh/id_rsa.pub

    # Opcionalmente, puedes eliminar también cualquier clave añadida al agente SSH
    ssh-add -d ~/.ssh/id_rsa
    ```