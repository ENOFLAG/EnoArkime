FROM ubuntu:20.04

ENV VERSION=3.1.1

ADD https://s3.amazonaws.com/files.molo.ch/builds/ubuntu-20.04/arkime_$VERSION-1_amd64.deb .
RUN apt-get update && \
    apt-get install -y htop nano tree curl libwww-perl libjson-perl ethtool libyaml-dev && \
    dpkg -i arkime_$VERSION-1_amd64.deb && \
    apt-get install -y libmagic-dev && \
    rm -rf arkime_$VERSION-1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://raw.githubusercontent.com/wireshark/wireshark/master/manuf > /opt/arkime/etc/oui.txt
RUN curl https://www.iana.org/assignments/ipv4-address-space/ipv4-address-space.csv > /opt/arkime/etc/ipv4-address-space.csv

COPY elasticsearch_init.sh elasticsearch_init.sh
COPY arkime-viewer.sh arkime-viewer.sh
COPY arkime-capture.sh arkime-capture.sh
COPY docker-entrypoint.sh docker-entrypoint.sh
COPY config.ini /opt/arkime/etc/config.ini

ENTRYPOINT /docker-entrypoint.sh
