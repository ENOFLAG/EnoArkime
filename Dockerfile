FROM ubuntu:18.04

ENV MOLOCH_VERSION "moloch_2.1.0-1_amd64.deb"

RUN apt-get update && apt-get install -y --no-install-recommends wget libwww-perl libjson-perl ethtool libyaml-dev pwgen curl libmagic-dev
RUN curl https://files.molo.ch/builds/ubuntu-18.04/$MOLOCH_VERSION > $MOLOCH_VERSION
RUN dpkg -i /$MOLOCH_VERSION
RUN /data/moloch/bin/moloch_update_geo.sh

RUN mkdir -p /data/moloch/raw
COPY ./config.ini /data/moloch/etc/config.ini
WORKDIR /data/moloch
COPY *.sh ./
