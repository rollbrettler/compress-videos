FROM ruby:2.2-wheezy

MAINTAINER Tim Petter <tim@timpetter.de>

ADD build/ /usr/bin

RUN gem install /usr/bin/compress-videos.gem

VOLUME ["/source", "/destination", "/tmp"]
WORKDIR /
CMD ["compress-videos"]
