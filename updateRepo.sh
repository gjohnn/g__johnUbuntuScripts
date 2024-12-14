#!/bin/bash

# Obtener la rama actual
currentBranch=$(git branch --show-current)

# Verificar si estamos en un repo Git
if [ -z "$currentBranch" ]; then
  echo "No estás en un repositorio Git. Por favor, navega a un directorio Git válido."
  exit 1
fi

echo "Rama actual: $currentBranch"
echo "Preparando el commit..."

# Solicitar el mensaje del commit
read -p "Ingresa el nombre del commit: " nameCommit

# Validar si se proporcionó un mensaje
if [ -z "$nameCommit" ]; then
  echo "El nombre del commit no puede estar vacío. Abortando..."
  exit 1
fi

# Añadir cambios y realizar el commit
git add .
git commit -m "$nameCommit"

# Push a la rama remota
git push origin "$currentBranch"

echo "¡Commit y push exitosos a la rama $currentBranch!"
