#!/bin/bash

# Variables
EMAIL="tu_email@example.com"
GITHUB_USERNAME="tu_usuario_github"
REPO_NAME="nombre_del_repositorio"

# Comprobar si ya existen claves SSH
if [ -f ~/.ssh/id_rsa ] || [ -f ~/.ssh/id_rsa.pub ]; then
  echo "Ya existen claves SSH en ~/.ssh/id_rsa y ~/.ssh/id_rsa.pub. Aborta para evitar sobrescribir."
  exit 1
fi

# Generar claves SSH
echo "Generando claves SSH..."
if ! ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f ~/.ssh/id_rsa -N ""; then
  echo "Error: Fallo en la generación de claves SSH."
  exit 1
fi

# Añadir clave SSH al agente
echo "Añadiendo clave SSH al agente..."
eval "$(ssh-agent -s)"
if ! ssh-add ~/.ssh/id_rsa; then
  echo "Error: Fallo al añadir la clave SSH al agente."
  exit 1
fi

# Copiar clave pública
echo "Tu clave pública es:"
cat ~/.ssh/id_rsa.pub

# Solicitar al usuario que agregue la clave pública a GitHub
echo "Por favor, añade la clave pública anterior a tu cuenta de GitHub."
echo "Ve a https://github.com/settings/keys y añade una nueva clave SSH."
read -p "Presiona [Enter] una vez que hayas añadido la clave a GitHub..."

# Verificar la clave SSH
echo "Verificando la clave SSH..."
# Ejecutar la conexión SSH y capturar la salida
SSH_OUTPUT=$(ssh -T git@github.com 2>&1)
# Verificar la salida para determinar si la autenticación fue exitosa
if [[ $SSH_OUTPUT == *"successfully authenticated"* ]]; then
  echo "La clave SSH está configurada correctamente y la autenticación con GitHub fue exitosa."
else
  echo "Error: La clave SSH no está configurada correctamente o la autenticación con GitHub falló."
  echo "$SSH_OUTPUT"
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