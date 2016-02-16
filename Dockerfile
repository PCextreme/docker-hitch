FROM ubuntu:15.10

MAINTAINER Wido den Hollander <wido@widodh.nl>

ENV HITCH_VERSION 1.1.1
ENV HITCH_USER nobody
ENV HITCH_GROUP nogroup
ENV HITCH_CONFIG /etc/hitch/hitch.conf
ENV HITCH_WORKERS 1

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

RUN mkdir /etc/hitch

COPY hitch.conf /etc/hitch/hitch.conf

ADD run.sh /usr/local/sbin/run.sh

RUN chmod +x /usr/local/sbin/run.sh

EXPOSE 443

CMD ["run.sh"]
