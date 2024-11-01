
# Git Flow Scripts para Feature e Release

Este repositório contém scripts Bash para facilitar a criação e finalização de branches de `feature`, `release` e `hotfix`, seguindo a metodologia **Git Flow**. O uso dos scripts reduz o tempo necessário para criar e gerenciar estas branches.

## Configuração Inicial

1. Clone ou baixe este repositório na sua máquina.
2. Defina os aliases globais no Git para usar os comandos personalizados:

   ```bash
   git config --global alias.feature '!sh <caminho>/feature.sh'
   git config --global alias.release '!sh <caminho>/release.sh'
   git config --global alias.hotfix '!sh <caminho>/hotfix.sh'
   git config --global alias.end '!sh <caminho>/finalizar_branch.sh'
   ```

   > Substitua `<caminho>` pelo diretório onde os scripts `feature.sh`, `release.sh`, `hotfix.sh` e `finalizar_branch.sh` estão salvos.

## Scripts

### Criando uma Feature

Para criar uma nova branch de feature:

```bash
git feature <nome-da-feature>
```

Este comando executa o script `feature.sh`, que:
- Verifica se o nome da feature foi informado.
- Cria a branch `feature/<nome-da-feature>` a partir da branch `master`.
- Configura a branch `feature` no repositório remoto.

### Criando uma Release a partir de uma Feature

Para criar uma nova branch de release:

```bash
git release
```

Este comando executa o script `release.sh`, que:
- Verifica se a branch atual é uma branch de `feature`.
- Cria uma nova branch `release` baseada na branch de `feature`.
- Configura a branch `release` no repositório remoto.

### Criando um Hotfix

Para criar uma nova branch de hotfix:

```bash
git hotfix <nome-do-hotfix>
```

Este comando executa o script `hotfix.sh`, que:
- Verifica se o nome do hotfix foi informado.
- Cria a branch `hotfix/<nome-do-hotfix>` a partir da branch `master`.
- Configura a branch `hotfix` no repositório remoto.

### Finalizando uma Branch de Feature ou Release

Para finalizar uma branch de feature ou release:

```bash
git end <nome-da-branch>
```

Este comando executa o script `finalizar_branch.sh`, que:
- Deleta a branch local e remota.
- Ao deletar uma feature a release é deletada
- É possivel também deltar hotfix

## Exemplo de Uso

1. **Criando uma Feature:**
   ```bash
   git feature minha-nova-feature
   ```

   - Este comando cria uma branch chamada `feature/minha-nova-feature` e a sincroniza com o repositório remoto.

2. **Criando uma Release:**
   ```bash
   git release
   ```

   - Este comando cria uma branch de `release` baseada na branch de `feature` atual e a configura no repositório remoto.

3. **Criando um Hotfix:**
   ```bash
   git hotfix meu-hotfix
   ```

   - Este comando cria uma branch de `hotfix` a partir da branch `master`.

4. **Finalizando uma Branch:**
   ```bash
   git end feature/minha-nova-feature
   ```

   - Este comando finaliza a branch de feature e release.

## Observação

Certifique-se de estar na branch correta ao criar uma `release` ou `hotfix`. Releases só podem ser criadas a partir de branches de `feature`.

## Estrutura do Projeto

```plaintext
.
├── feature.sh          # Script para criação de branches de feature
├── release.sh          # Script para criação de branches de release
├── hotfix.sh           # Script para criação de branches de hotfix
└── finalizar_branch.sh  # Script para finalizar branches de feature e release
```

### Exemplos

1. **Para criar uma nova feature chamada `ajuste-UI`:**
   ```bash
   git feature ajuste-UI
   ```

2. **Para criar uma release a partir de uma feature existente:**
   ```bash
   git release
   ```

3. **Para criar um hotfix chamado `corrigir-bug`:**
   ```bash
   git hotfix corrigir-bug
   ```

4. **Para finalizar uma branch chamada `feature/ajuste-UI`:**
   ```bash
   git end feature/ajuste-UI
   ```

## Licença

Este projeto é de uso livre. Sinta-se à vontade para modificar e compartilhar.
