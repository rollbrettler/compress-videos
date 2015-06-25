FROM ruby:2.2-wheezy

MAINTAINER Tim Petter <tim@timpetter.de>

RUN apt-get -y --force-yes update
RUN apt-get install --assume-yes --quiet --force-yes wget yasm autoconf automake build-essential libass-dev \
     libfreetype6-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev \
     libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texi2html zlib1g-dev libx264-dev libmp3lame-dev

RUN mkdir ~/ffmpeg_sources \
    && cd ~/ffmpeg_sources \
    && wget http://ffmpeg.org/releases/ffmpeg-2.6.2.tar.bz2 \
    && tar xjvf ffmpeg-2.6.2.tar.bz2 >/dev/null 2>&1 \
    && cd ffmpeg-2.6.2 \
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

# RUN apt-get -y --force-yes install libav-tools
# RUN mkdir -p /ffmpeg_build /build
# ADD ffmpeg_build/ /ffmpeg_build
# ADD build/ /usr/bin
# ADD build/ /build

RUN mkdir -p /test
ADD build/ /test
RUN gem install /test/compress-videos.gem

VOLUME ["/source", "/destination", "/tmp"]
WORKDIR /
CMD ["compress-videos"]
