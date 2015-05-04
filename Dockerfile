FROM ruby:2.2-wheezy

MAINTAINER Tim Petter <tim@timpetter.de>

RUN apt-get update --assume-yes --quiet
RUN apt-get install --assume-yes --quiet --force-yes wget yasm autoconf automake build-essential libass-dev \
    libfreetype6-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev \
    libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texi2html zlib1g-dev libx264-dev libmp3lame-dev

RUN mkdir ~/ffmpeg_sources \
    && cd ~/ffmpeg_sources \
    && wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 \
    && tar xjvf ffmpeg-snapshot.tar.bz2 >/dev/null 2>&1 \
    && cd ffmpeg \
    && ./configure \
      --pkg-config-flags="--static" \
      --bindir="/usr/bin" \
      --enable-gpl \
      --enable-libass \
      --enable-libfreetype \
      --enable-libmp3lame \
      --enable-libtheora \
      --enable-libvorbis \
      --enable-libx264 \
      --enable-nonfree \
    && make \
    && make install \
    && make distclean \
    && hash -r \
    && rm -rf ~/ffmpeg_sources

RUN apt-get purge --assume-yes --quiet --force-yes wget yasm autoconf automake build-essential libass-dev \
    libfreetype6-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev \
    libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texi2html zlib1g-dev libx264-dev libmp3lame-dev

ADD . /

RUN chmod +x /run.rb

RUN gem install bundler
RUN bundle install

VOLUME ["/source", "/destination", "/tmp"]
WORKDIR /
CMD ["ruby", "/run.rb"]
