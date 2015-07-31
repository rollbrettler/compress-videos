#!/bin/bash

# build gem
cd /src
gem install bundler
bundle install
gem build compress-videos.gemspec
mv compress-videos-$(echo $VERSION).gem /build/compress-videos.gem
