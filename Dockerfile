FROM ubuntu:18.04
MAINTAINER Andy Wick <andy.wick@oath.com>

RUN apt-get update && \
apt-get install -y lsb-release ruby-dev make python-pip git libtest-differences-perl sudo wget && \
(cd /tmp && wget https://packages.ntop.org/apt-stable/18.04/all/apt-ntop-stable.deb && dpkg -i apt-ntop-stable.deb) && \
apt-get update && \
apt-get install -y pfring && \
gem install --no-ri --no-rdoc fpm && \
git clone https://github.com/aol/moloch && \
(cd moloch ; ./easybutton-build.sh --daq --pfring --install) && \
mv moloch/thirdparty / && \
rm -rf moloch && \
rm -rf /var/lib/apt/lists/*

WORKDIR /data/moloch
RUN curl https://raw.githubusercontent.com/maxmind/MaxMind-DB/master/test-data/GeoIP2-Anonymous-IP-Test.mmdb > /data/moloch/etc/GeoLite2-Country.mmdb
RUN curl https://raw.githubusercontent.com/wireshark/wireshark/master/manuf > /data/moloch/etc/oui.txt
RUN mkdir raw


COPY *.sh ./

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
