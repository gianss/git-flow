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

echo "Checkout master"
git checkout master
echo "Git pull master"
git pull
echo "Criando nova feature"
git checkout -B "$feature" master
git push --set-upstream origin "$feature"
