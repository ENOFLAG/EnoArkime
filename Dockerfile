FROM ubuntu:22.04

ENV VERSION=4.5.0

ADD https://s3.amazonaws.com/files.molo.ch/builds/ubuntu-22.04/arkime_${VERSION}-1_amd64.deb .
RUN apt update && \
    apt install -y htop nano tree curl libwww-perl libjson-perl ethtool libyaml-dev liblua5.4-0 libmaxminddb0 libcurl4 libpcap0.8 libglib2.0-0 libnghttp2-14 libyara8 librdkafka1 && \
    dpkg -i arkime_${VERSION}-1_amd64.deb && \
    apt install -y libmagic-dev && \
    rm -rf arkime_$VERSION-1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://fossies.org/linux/misc/wireshark-4.0.8.tar.xz/wireshark-4.0.8/manuf?m=b > /opt/arkime/etc/oui.txt
RUN curl https://www.iana.org/assignments/ipv4-address-space/ipv4-address-space.csv > /opt/arkime/etc/ipv4-address-space.csv

COPY elasticsearch_init.sh elasticsearch_init.sh
COPY arkime-viewer.sh arkime-viewer.sh
COPY arkime-capture.sh arkime-capture.sh
COPY docker-entrypoint.sh docker-entrypoint.sh
COPY config.ini /opt/arkime/etc/config.ini

ENTRYPOINT /docker-entrypoint.sh
