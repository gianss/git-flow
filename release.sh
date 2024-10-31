#!/bin/bash

feature=$(git symbolic-ref --short HEAD | sed "s/release/feature/")
release=$(git symbolic-ref --short HEAD | sed "s/feature/release/")
remote_release="$(git for-each-ref --format='%(upstream:short)' refs/heads/$release)"

if [ "$(git symbolic-ref --short HEAD)" == "$release" ]; then
    echo "Releases só podem ser criadas a partir de features"
    exit -1
fi

echo "Feature: $feature"
echo "Release: $release"

if [ "$remote_release" ]; then
    echo "Deletando release remota $release"
    git push origin ":$release"
fi

if [ "$(git rev-parse --quiet --verify $release)" ]; then
    echo "Deletando release local $release"
    git branch -D $release
fi

echo "Criando nova release"
git checkout -b $release
git push --set-upstream origin $release
echo "Voltando para a feature"
git checkout "$feature"
