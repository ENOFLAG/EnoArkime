FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends wget libwww-perl libjson-perl ethtool libyaml-dev pwgen curl libmagic-dev
RUN curl https://files.molo.ch/builds/ubuntu-18.04/moloch_2.0.1-1_amd64.deb > moloch_2.0.1-1_amd64.deb
RUN dpkg -i /moloch_2.0.1-1_amd64.deb
RUN /data/moloch/bin/moloch_update_geo.sh

RUN mkdir -p /data/moloch/raw
COPY ./config.ini /data/moloch/etc/config.ini
WORKDIR /data/moloch
COPY *.sh ./
