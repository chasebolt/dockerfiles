FROM ubuntu

ENV TERRARIA_VERSION=1353

RUN apt-get update && \
  apt-get install -y wget unzip

WORKDIR /src

RUN wget -O terraria.zip "http://terraria.org/server/terraria-server-${TERRARIA_VERSION}.zip" && \
  unzip terraria.zip "${TERRARIA_VERSION}/Linux/*" && \
  rm terraria.zip && \
  chmod +x "${TERRARIA_VERSION}/Linux/TerrariaServer.bin.x86_64"

ADD config.txt /config.txt.default
ADD run.sh /run.sh

VOLUME /data
EXPOSE 7777/tcp 7777/udp

CMD '/run.sh'
