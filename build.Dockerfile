FROM alpine:3.3

MAINTAINER Tim Petter <tim@timpetter.de>

ENV VERSION 0.0.0

RUN mkdir -p /src
ADD . /src

RUN apk add --update ruby ruby-rdoc ruby-irb ruby-io-console && rm -rf /var/cache/apk/*

RUN chmod +x /src/build.sh

VOLUME ["/build"]
WORKDIR /build

CMD ["/src/build.sh"]
