FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends git wget libwww-perl libjson-perl ethtool libyaml-dev pwgen curl libmagic-dev sudo python2.7
WORKDIR /
RUN git clone https://github.com/ENOFLAG/enoch.git
WORKDIR /enoch
RUN git submodule init
ENV PYTHON=/usr/bin/python2.7
RUN sed -i 's/sudo env/sudo -E env/' ./easybutton-build.sh
RUN ./easybutton-build.sh --install
WORKDIR /data/moloch
RUN curl https://raw.githubusercontent.com/maxmind/MaxMind-DB/master/test-data/GeoIP2-Anonymous-IP-Test.mmdb > /data/moloch/etc/GeoLite2-Country.mmdb
RUN curl https://raw.githubusercontent.com/wireshark/wireshark/master/manuf > /data/moloch/etc/oui.txt
RUN mkdir raw

COPY ./config.ini ./etc/config.ini
COPY *.sh ./

RUN echo FOOECHO23
COPY ./hello_world/target/debug/libhello_world.so ./plugins/libhello_world.so

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
