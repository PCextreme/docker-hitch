FROM ubuntu:15.10

MAINTAINER Wido den Hollander <wido@widodh.nl>

ENV HITCH_VERSION 1.1.1

RUN apt-get update

RUN apt-get install -y curl libev-dev libssl-dev autoconf libtool python-docutils make pkg-config

RUN cd /usr/src \
    && curl -SL -o hitch.tar.gz https://github.com/varnish/hitch/archive/hitch-$HITCH_VERSION.tar.gz \
    && mkdir /usr/src/hitch \
    && tar xf hitch.tar.gz -C /usr/src/hitch --strip-components=1 \
    && cd hitch \
    && ./bootstrap \
    && ./configure --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/libexec --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib \
    && make \
    && make install

RUN mkdir /etc/hitch && mkdir /etc/hitch/certs && touch /etc/hitch/hitch.conf

EXPOSE 443

CMD ["hitch", "--pidfile=/run/hitch.pid", "--user", "nobody", "--group", "nogroup", "--config", "/etc/hitch/hitch.conf"]
