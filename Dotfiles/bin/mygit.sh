#!/bin/bash

# Verifica si se proporciona un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 \"Mensaje de commit\""
    exit 1
fi

# Asegurarse de estar en un directorio de repositorio Git
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "No estás en un repositorio Git."
    exit 1
fi

# Añadir todos los archivos al área de preparación
git add . >/dev/null 2>&1

# Realizar un commit con el mensaje proporcionado como argumento
git commit -m "$1" >/dev/null 2>&1

# Obtener el nombre de la rama actual
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Verificar si la rama actual es "main" o "master"
if [ "$current_branch" != "main" ] && [ "$current_branch" != "master" ]; then
    echo "No estás en la rama 'main' ni en la rama 'master'. No se puede realizar el push."
    exit 1
fi

# Empujar al repositorio remoto
git push origin "$current_branch" >/dev/null 2>&1

# Mostrar los cambios realizados en este commit
echo -e "\nCambios en el commit:"
git show --stat HEAD

# Mostrar el historial de commits y en qué commit estamos
echo -e "\nHistorial de commits:"
git log --oneline --graph --all
