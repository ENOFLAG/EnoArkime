FROM ubuntu:18.04
MAINTAINER Andy Wick <andy.wick@oath.com>

ARG VERSION=2.3.2-1

RUN apt-get update && \
    apt-get install -y libwww-perl libjson-perl ethtool libyaml-dev libmagic1 curl wget && \
    wget https://s3.amazonaws.com/files.molo.ch/builds/ubuntu-18.04/moloch_${VERSION}_amd64.deb && \
    dpkg -i moloch_${VERSION}_amd64.deb && \
    rm moloch_${VERSION}_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data/moloch
RUN curl https://raw.githubusercontent.com/maxmind/MaxMind-DB/master/test-data/GeoIP2-Anonymous-IP-Test.mmdb > /data/moloch/etc/GeoLite2-Country.mmdb
RUN curl https://raw.githubusercontent.com/wireshark/wireshark/master/manuf > /data/moloch/etc/oui.txt
RUN mkdir raw


COPY *.sh ./
COPY config.default.ini ./etc/config.ini

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
