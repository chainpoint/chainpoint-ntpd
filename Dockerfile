FROM alpine

LABEL MAINTAINER="Glenn Rempe <glenn@tierion.com>"

ENV TZ=UTC

RUN apk update && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

RUN apk add --update tini openntpd --no-cache

ADD ntpd.conf /etc/ntpd.conf

EXPOSE 123/udp

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ntpd", "-v" ,"-d" ,"-f", "/etc/ntpd.conf", "-s"]
