# Versão multiplataforma (.zip): RFB recomenda OpenJDK 11 (JVM externa).
FROM eclipse-temurin:17-jdk-jammy

ARG ANO
ENV ANO=$ANO
ARG VERSAO
ENV VERSAO=$VERSAO

# Swing/AWT (X11 no host) + Firefox (tarball Mozilla; pacote apt no Ubuntu é snap e não roda no Docker).
RUN apt-get update \
    && apt-get install -o APT::Immediate-Configure=0 -y --no-install-recommends \
        ca-certificates \
        wget \
        unzip \
        xz-utils \
        xdg-utils \
        fontconfig \
        libasound2 \
        libdbus-glib-1-2 \
        libfreetype6 \
        libgtk-3-0 \
        libnss3 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        libcairo2 \
        libcups2 \
        libdrm2 \
        libgbm1 \
        libpango-1.0-0 \
        libgdk-pixbuf-2.0-0 \
        libx11-6 \
        libx11-xcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxrandr2 \
        libxrender1 \
        libxtst6 \
        libxi6 \
    && wget -q -O /tmp/firefox.tar.xz \
        "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=pt-BR" \
    && tar -xJf /tmp/firefox.tar.xz -C /opt \
    && ln -sf /opt/firefox/firefox /usr/local/bin/firefox \
    && rm /tmp/firefox.tar.xz \
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
