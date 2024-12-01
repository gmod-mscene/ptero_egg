FROM ubuntu:22.04

RUN dpkg --add-architecture i386 \
	&& apt update \
	&& apt upgrade -y \
	&& apt install -y curl wget lib32tinfo6 lib32stdc++6 libstdc++6 libtinfo5:i386 git \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/container container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container/steamcmd
RUN curl -o ./steamcmd_linux.tar.gz "http://media.steampowered.com/client/steamcmd_linux.tar.gz" &&\
	tar -xvzf ./steamcmd_linux.tar.gz &&\
	./steamcmd.sh +login anonymous +quit

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh
CMD [ "/bin/bash", "/entrypoint.sh" ]
