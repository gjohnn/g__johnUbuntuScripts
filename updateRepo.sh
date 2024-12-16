#!/bin/bash

# Obtener la rama actual
currentBranch=$(git branch --show-current)

# Verificar si estamos en un repo Git
if [ -z "$currentBranch" ]; then
  echo "There is no git repo here!"
  exit 1
fi

echo "Current branch: $currentBranch"
echo "Making commit..."

# Solicitar el mensaje del commit
read -p "Enter commit name: " nameCommit

# Validar si se proporcionó un mensaje
if [ -z "$nameCommit" ]; then
  echo "Commit's name can not be empty. Aborting..."
  exit 1
fi

# Añadir cambios y realizar el commit
git add .
git commit -m "$nameCommit"

# Push a la rama remota
git push origin "$currentBranch"

echo "¡Commit and push completed to branch -> $currentBranch!"

