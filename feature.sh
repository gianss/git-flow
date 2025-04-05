#!/bin/bash

feature="feature/$1"
remote_feature="$(git for-each-ref --format='%(upstream:short)' refs/heads/$feature)"

if [ "$feature" == "feature/" ]; then
    echo "Por favor, informe o nome da feature"
    exit -1
fi

echo "Feature: $feature"

if git rev-parse --quiet --verify "$feature"; then
    echo "A $feature já existe"
    git checkout "$feature"
    exit -1
fi

echo "Checkout prd"
git checkout prd
echo "Git pull prd"
git pull
echo "Criando nova feature"
git checkout -B "$feature" prd
git push --set-upstream origin "$feature"
