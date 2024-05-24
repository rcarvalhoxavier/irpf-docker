# Projeto IRPF Docker

Este repositório contém um Dockerfile e um Makefile para construir e executar um container Docker que baixa e executa o aplicativo IRPF para o ano e versão especificada.

## Pré-requisitos

- Docker
- Make

## Estrutura do Projeto

- `Dockerfile`: Contém os comandos para construir a imagem Docker.
- `entrypoint.sh`: Script de entrada usado para iniciar o IRPF.
- `Makefile`: Contém os métodos para construir e executar o container Docker.

## Instruções

### 1. Clone o repositório

```sh
git clone git@github.com:rcarvalhoxavier/irpf-docker.git
cd irpf-docker
```

### 2. Defina o ano e versão no Makefile

```makefile
ANO=2024
VERSAO=1.1
```

### 3. Construa a imagem Docker

```sh
make build
```


### 4. Execute o container

Caso a imagem não exista localmente, irá baixar do repositório de imagens do github

```sh
make run
```

### 5. Construa e Execute

```sh
make all
```


## Contribuição

Sinta-se à vontade para abrir issues e pull requests para melhorar este projeto.