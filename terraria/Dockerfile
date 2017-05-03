FROM ubuntu

ENV TERRARIA_VERSION=1353

RUN apt-get update \
    && apt-get install -y \
        wget \
        unzip

RUN wget -O tini.deb "https://github.com/krallin/tini/releases/download/v0.14.0/tini_0.14.0-amd64.deb" \
    && dpkg -i tini.deb \
    && rm tini.deb

RUN wget -O terraria.zip "http://terraria.org/server/terraria-server-${TERRARIA_VERSION}.zip" \
    && unzip terraria.zip "${TERRARIA_VERSION}/Linux/*" \
    && mv "${TERRARIA_VERSION}/Linux" /terraria \
    && chmod +x /terraria/TerrariaServer.bin.x86_64 \
    && rm terraria.zip

COPY ["run.sh", "config.txt", "/"]

ENTRYPOINT ["tini", "/run.sh"]
