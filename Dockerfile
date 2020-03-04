FROM ubuntu:18.04

ENV MOLOCH_VERSION "moloch_2.1.0-1_amd64.deb"

RUN apt-get update && apt-get install -y --no-install-recommends wget libwww-perl libjson-perl ethtool libyaml-dev pwgen curl libmagic-dev
RUN curl https://files.molo.ch/builds/ubuntu-18.04/$MOLOCH_VERSION > $MOLOCH_VERSION
RUN dpkg -i /$MOLOCH_VERSION
WORKDIR /data/moloch
RUN curl https://raw.githubusercontent.com/maxmind/MaxMind-DB/master/test-data/GeoIP2-Anonymous-IP-Test.mmdb > /data/moloch/etc/GeoLite2-Country.mmdb
RUN curl https://raw.githubusercontent.com/wireshark/wireshark/master/manuf > /data/moloch/etc/oui.txt
RUN mkdir raw

COPY ./config.ini ./etc/config.ini
COPY *.sh ./

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
