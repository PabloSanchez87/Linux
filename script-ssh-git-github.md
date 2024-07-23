# SSH y Git - GitHub

1. Generación de claves SSH.
2. Configuración de la clave pública en GitHub.
3. Configuración de Git con tus credenciales.
4. Clonación de un repositorio de GitHub.
5. Sincronización de cambios entre el repositorio local y GitHub.

El script será en Bash y asumirá que ya tienes ssh, git, y curl instalados. 

El script también requerirá que tengas una cuenta en GitHub y un repositorio creado.

## Script en bash
```bash
#!/bin/bash

# Variables
EMAIL="tu_email@example.com"
GITHUB_USERNAME="tu_usuario_github"
REPO_NAME="nombre_del_repositorio"

# Generar claves SSH
echo "Generando claves SSH..."
ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f ~/.ssh/id_rsa -N ""

# Añadir clave SSH al agente
echo "Añadiendo clave SSH al agente..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Copiar clave pública
echo "Tu clave pública es:"
cat ~/.ssh/id_rsa.pub

# Solicitar al usuario que agregue la clave pública a GitHub
echo "Por favor, añade la clave pública anterior a tu cuenta de GitHub."
echo "Ve a https://github.com/settings/keys y añade una nueva clave SSH."
read -p "Presiona [Enter] una vez que hayas añadido la clave a GitHub..."

# Configurar Git con las credenciales del usuario
echo "Configurando Git..."
git config --global user.name "$GITHUB_USERNAME"
git config --global user.email "$EMAIL"

# Clonar el repositorio de GitHub
echo "Clonando el repositorio de GitHub..."
git clone git@github.com:$GITHUB_USERNAME/$REPO_NAME.git

# Entrar en el directorio del repositorio
cd $REPO_NAME

# Crear un archivo de prueba
echo "Creando un archivo de prueba..."
echo "# $REPO_NAME" >> README.md
git add README.md
git commit -m "Añadir archivo README.md"
git push origin master

echo "Configuración y sincronización completadas."
```

## Instrucciones para ejecutar el script
1. Edita el script
    - Asegúrate de cambiar las variables **EMAIL, GITHUB_USERNAME, y REPO_NAME** con tus propias credenciales y el **nombre de tu repositorio**.
2. Haz el script ejecutable:
    ```bash
    chmod +x setup_git_github.sh
    ``` 
3. Ejecutar el script:
    ```bash
    ./setup_git_github.sh
    ```

- El script guiará a través de los pasos necesarios para:
    - Configurar las claves SSH
    - Añadir la clave pública a GitHub 
    - Configurar Git con tus credenciales 
    - Clonar un repositorio de GitHub
    - Incluyendo la creación de un archivo de prueba y su sincronización.
