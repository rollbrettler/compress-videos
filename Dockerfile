FROM ruby:2.2-wheezy

MAINTAINER Tim Petter <tim@timpetter.de>

RUN apt-get update --assume-yes --quiet
RUN apt-get install --assume-yes --quiet ffmpeg x264

ADD . /

RUN chmod +x /run.rb

RUN gem install bundler
RUN bundle install

VOLUME ["/source", "/destination", "/tmp"]
WORKDIR /
CMD ["ruby", "/run.rb"]
