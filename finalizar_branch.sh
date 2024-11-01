#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: git finaliza_branch <nome-da-branch>"
    exit 1
fi

branch="$1"

if ! git rev-parse --quiet --verify "$branch" > /dev/null; then
    echo "A branch $branch não existe."
    exit 1
fi

# Função para deletar a branch de release associada
delete_release_branch() {
    release_branch="release/${branch#feature/}"

    if git rev-parse --quiet --verify "$release_branch" > /dev/null; then
        echo "Deletando a branch de release associada: $release_branch..."
        git branch -d "$release_branch"
        git push origin --delete "$release_branch"
        echo "Branch de release $release_branch deletada com sucesso!"
    else
        echo "Nenhuma branch de release associada a $branch foi encontrada."
    fi
}

# Função para deletar a branch de hotfix associada
delete_hotfix_branch() {
    hotfix_branch="hotfix/${branch#feature/}"

    if git rev-parse --quiet --verify "$hotfix_branch" > /dev/null; then
        echo "Deletando a branch de hotfix associada: $hotfix_branch..."
        git branch -d "$hotfix_branch"
        git push origin --delete "$hotfix_branch"
        echo "Branch de hotfix $hotfix_branch deletada com sucesso!"
    else
        echo "Nenhuma branch de hotfix associada a $branch foi encontrada."
    fi
}

# Verifica se a branch é de feature ou release e executa as operações de finalização
if [[ "$branch" == feature/* ]]; then
    echo "Finalizando a branch de feature $branch..."

    # Deletar a branch de feature
    git branch -d "$branch"
    git push origin --delete "$branch"
    echo "Branch de feature $branch finalizada com sucesso!"

    # Deletar a branch de release e hotfix associadas, se existirem
    delete_release_branch
    delete_hotfix_branch

elif [[ "$branch" == release/* ]]; then
    echo "Finalizando a branch de release $branch..."
    git branch -d "$branch"
    git push origin --delete "$branch"
    echo "Branch de release $branch finalizada com sucesso!"

    # Deletar a branch de hotfix associada, se existir
    delete_hotfix_branch

elif [[ "$branch" == hotfix/* ]]; then
    echo "Finalizando a branch de hotfix $branch..."
    git branch -d "$branch"
    git push origin --delete "$branch"
    echo "Branch de hotfix $branch finalizada com sucesso!"
else
    echo "A branch $branch não é uma branch de feature, release ou hotfix."
    exit 1
fi

# Retorna para a branch master após finalizar
git checkout master
