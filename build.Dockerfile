FROM ruby:2.2-wheezy

MAINTAINER Tim Petter <tim@timpetter.de>

ENV VERSION 0.0.0

RUN apt-get update --assume-yes --quiet

RUN mkdir -p /src

ADD . /src

RUN chmod +x /src/build.sh

VOLUME ["/build"]
WORKDIR /build

CMD ["/src/build.sh"]
