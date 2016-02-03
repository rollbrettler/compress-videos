FROM alpine:3.3

MAINTAINER Tim Petter <tim@timpetter.de>

RUN apk add --update ruby ruby-rdoc ruby-irb ffmpeg && rm -rf /var/cache/apk/*

ADD build/ /
RUN gem install /compress-videos.gem

VOLUME ["/source", "/destination", "/tmp"]
WORKDIR /
CMD ["compress-videos"]
