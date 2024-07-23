#!/bin/bash

# Variables
EMAIL="tu_email@example.com"
GITHUB_USERNAME="tu_usuario_github"

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

echo "Configuración completada."