.PHONY: build run

# Defina o ano e versão como uma variável

#ANO=2023
#VERSAO=1.5

ANO=2025
VERSAO=1.3
REPO_IMAGE_TAG=ghcr.io/rcarvalhoxavier/irpf-docker:v$(ANO)-$(VERSAO)

build:
	@echo "Construindo a imagem Docker para o ano $(ANO)..."
	docker build \
	--build-arg ANO=$(ANO) \
	--build-arg VERSAO=$(VERSAO) \
	--network=host \
	-f Dockerfile \
	-t $(REPO_IMAGE_TAG) .

build-x:
	@echo "Construindo a imagem Docker para o ano $(ANO)..."
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max  \
	--label org.opencontainers.image.licenses=MIT \
	--label org.opencontainers.image.source=https://github.com/rcarvalhoxavier/irpf-docker \
	--label org.opencontainers.image.title=irpf-docker \
	--label org.opencontainers.image.url=https://github.com/rcarvalhoxavier/irpf-docker \
	--build-arg ANO=$(ANO) \
	--build-arg VERSAO=$(VERSAO) \
	--network=host \
	-f Dockerfile \
	-t $(REPO_IMAGE_TAG) .


run:
	@echo "Executando o container Docker para o ano $(ANO)..."
	docker run -it --rm --name irpf --network host \
		-e DISPLAY=$(DISPLAY) \
		-v $(HOME):/home/irpf \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		$(REPO_IMAGE_TAG)

all: build run