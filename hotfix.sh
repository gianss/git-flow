#!/bin/bash

hotfix="hotfix/$1"

if [ -z "$1" ]; then
    echo "Por favor, informe o nome do hotfix."
    exit 1
fi

if git rev-parse --quiet --verify "$hotfix" > /dev/null; then
    echo "A branch $hotfix já existe."
    git checkout "$hotfix"
    exit 1
fi

echo "Fazendo checkout na branch prod..."
git checkout prod

echo "Atualizando branch prod..."
git pull origin prod

echo "Criando a nova branch de hotfix: $hotfix"
git checkout -b "$hotfix"

git push --set-upstream origin "$hotfix"

echo "Branch de hotfix $hotfix criada com sucesso!"

