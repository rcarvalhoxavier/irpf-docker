.PHONY: build run

# Defina o ano e versão como uma variável

#ANO=2023
#VERSAO=1.5

ANO=2024
VERSAO=1.1

build:
	@echo "Construindo a imagem Docker para o ano $(ANO)..."
	docker build \
	--build-arg ANO=$(ANO) \
	--build-arg VERSAO=$(VERSAO) \
	--network=host \
	-f Dockerfile \
	-t irpf-$(ANO) .

run:
	@echo "Executando o container Docker para o ano $(ANO)..."
	docker run -it --rm --name irpf -e DISPLAY=$(DISPLAY) \
		-v $(HOME):/home/irpf \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		irpf-$(ANO)

all: build run