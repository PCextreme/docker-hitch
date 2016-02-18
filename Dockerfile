FROM alpine:3.3

MAINTAINER Wido den Hollander <wido@widodh.nl>

ARG HITCH_VERSION=1.1.1

ENV HITCH_USER nobody
ENV HITCH_GROUP nogroup
ENV HITCH_CONFIG /etc/hitch/hitch.conf
ENV HITCH_WORKERS 1

RUN apk add --no-cache openssl libev

RUN apk add --no-cache --virtual .build-deps curl libev-dev openssl-dev autoconf libtool py-docutils make automake pkgconfig gcc musl-dev \
    && mkdir /usr/src \
    && cd /usr/src \
    && curl -SL -o hitch.tar.gz https://github.com/varnish/hitch/archive/hitch-$HITCH_VERSION.tar.gz \
    && tar xzf hitch.tar.gz -C /usr/src \
    && cd hitch-hitch-$HITCH_VERSION \
    && ./bootstrap \
    && ./configure --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/libexec --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib \
    && make \
    && make install \
    && apk del .build-deps

RUN mkdir /etc/hitch

COPY hitch.conf /etc/hitch/hitch.conf

ADD run.sh /usr/sbin/run.sh

RUN chmod +x /usr/sbin/run.sh

EXPOSE 443

CMD ["run.sh"]
