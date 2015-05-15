FROM ruby:2.2-wheezy

MAINTAINER Tim Petter <tim@timpetter.de>

ADD build/ /usr/bin
ADD . /

RUN chmod +x /run.rb

RUN gem install bundler --without test
RUN bundle install

VOLUME ["/source", "/destination", "/tmp"]
WORKDIR /
CMD ["ruby", "/run.rb"]
