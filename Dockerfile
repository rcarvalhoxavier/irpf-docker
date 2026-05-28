FROM eclipse-temurin:21-jdk

ARG ANO
ENV ANO=$ANO
ARG VERSAO
ENV VERSAO=$VERSAO

# Runtime para Swing/AWT com DISPLAY do host (X11). Sem -dev nem libcanberra (removido no Ubuntu 24+).
RUN apt-get update \
    && apt-get install -o APT::Immediate-Configure=0 -y --no-install-recommends \
        ca-certificates \
        wget \
        unzip \
        fontconfig \
        libfreetype6 \
        libgtk-3-0 \
        libx11-6 \
        libxext6 \
        libxrender1 \
        libxtst6 \
        libxi6 \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://downloadirpf.receita.fazenda.gov.br/irpf/${ANO}/irpf/arquivos/IRPF${ANO}-$VERSAO.zip -O IRPF.zip

RUN unzip IRPF.zip -d /opt/

# Verifique se o 1001 é o mesmo user id
# de quem irá executar a imagem
# Execute `id` no terminal para verificar o id
RUN groupadd --gid 1001 irpf && \
    useradd --gid 1001 --uid 1001 --create-home --shell /bin/bash irpf

COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh

USER irpf

ENV TZ=America/Sao_Paulo

ENTRYPOINT ["./entrypoint.sh"]
