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

# Verificar la clave SSH
echo "Verificando la clave SSH..."
ssh -T git@github.com

if [ $? -ne 1 ]; then
  echo "Error: La clave SSH no está configurada correctamente."
  exit 1
fi

# Configurar Git con las credenciales del usuario
echo "Configurando Git..."
git config --global user.name "$GITHUB_USERNAME"
git config --global user.email "$EMAIL"

# Clonar el repositorio de GitHub
echo "Clonando el repositorio de GitHub..."
git clone git@github.com:$GITHUB_USERNAME/$REPO_NAME.git

if [ $? -ne 0 ]; then
  echo "Error: No se pudo clonar el repositorio. Verifica los permisos de acceso."
  exit 1
fi

# Entrar en el directorio del repositorio
cd $REPO_NAME

# Verificar si README.md ya existe
if [ -e README.md ]; then
  echo "El archivo README.md ya existe."
  # Crear un archivo de prueba
  echo "Creando un archivo de prueba..."
  echo "# $REPO_NAME" >> prueba.md
  git add prueba.md
  git commit -m "Añadir archivo prueba.md"
  git push origin main
else
  # Crear un archivo de prueba README
  echo "Creando un archivo de prueba..."
  echo "# $REPO_NAME" >> README.md
  git add README.md
  git commit -m "Añadir archivo README.md"
  git push origin main
fi

echo "Configuración y sincronización completadas."
```

## Instrucciones para ejecutar el script
1. Edita el script
    - Asegúrate de cambiar las variables **EMAIL, GITHUB_USERNAME, y REPO_NAME** con tus propias credenciales y el **nombre de tu repositorio**.
2. Haz el script ejecutable:
    ```bash
    chmod +x <nombre-script>.sh
    ``` 
3. Ejecutar el script:
    ```bash
    ./<nombre-script>.sh
    ```

- El script guiará a través de los pasos necesarios para:
    - Configurar las claves SSH
    - Añadir la clave pública a GitHub 
    - Configurar Git con tus credenciales 
    - Clonar un repositorio de GitHub
    - Incluyendo la creación de un archivo de prueba y su sincronización.

## Nota importante
 - El **script requiere interacción manual para agregar la clave SSH a GitHub**, ya que GitHub no permite la automatización de este proceso por razones de seguridad. 
 - Durante la ejecución, el script te mostrará la clave pública y te pedirá que la agregues manualmente a tu cuenta de GitHub siguiendo estos pasos: 
    - Ve a [GitHub - SSH and GPG keys](https://github.com/settings/keys).
    - Haz clic en **"New SSH key"**.
    - Pega la **clave pública** que te proporciona el script y dale un nombre.
    - Guarda la clave.
- Una vez que la clave esté añadida, puedes continuar con la ejecución del script.