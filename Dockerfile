FROM a1exei/debian:stable-slim
RUN apt-get update && \
    apt-get install -y curl bzip2 pwgen && \
    apt-get clean
COPY ./startup.sh /startup.sh
RUN chmod +x /startup.sh
WORKDIR /opt
RUN curl -o teamspeak3-server_linux_amd64.tar.bz2 http://dl.4players.de/ts/releases/3.8.0/teamspeak3-server_linux_amd64-3.8.0.tar.bz2 && \
    tar xfj teamspeak3-server_linux_amd64.tar.bz2 && mv teamspeak3-server_linux_amd64 teamspeak && \
    rm -f teamspeak3-server_linux_amd64.tar.bz2
EXPOSE 9987/udp 10011 30033
VOLUME ["/data"]
CMD ["/startup.sh"]
