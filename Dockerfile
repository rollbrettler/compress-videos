FROM ruby:2.2-wheezy

MAINTAINER Tim Petter <tim@timpetter.de>

RUN apt-get -y --force-yes update
RUN apt-get -y --force-yes install autoconf automake build-essential libass-dev libfreetype6-dev \
  libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev \
  libxcb-xfixes0-dev pkg-config texi2html zlib1g-dev
RUN apt-get -y --force-yes install libx264-dev libav-tools

ADD build/ /usr/bin

RUN gem install /usr/bin/compress-videos.gem

VOLUME ["/source", "/destination", "/tmp"]
WORKDIR /
CMD ["compress-videos"]
