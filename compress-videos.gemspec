lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name        = 'compress-videos'
  spec.version     = CompressVideos::VERSION
  spec.date        = '2015-06-04'
  spec.summary     = 'Automatically compresss a video'
  spec.description = 'Compresses the first video in a given folder and keeps all subtitles and audio layers'
  spec.authors     = ['Tim Petter']
  spec.email       = 'tim@timpetter.de'
  spec.files       = ['lib/compress_videos.rb',
                      'lib/version.rb',
                      'lib/compress_videos/compressor/ffmpeg.rb',
                      'lib/compress_videos/models/video.rb']
  spec.homepage    = 'https://github.com/rollbrettler/compress-videos'
  spec.license     = 'MIT'

  spec.executables   = 'compress-videos'
  spec.test_files    = spec.files.grep(%r{/^(test|spec|features)\//})
  spec.require_paths = ['lib', 'lib/compress_videos']
  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'fakefs'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_runtime_dependency 'streamio-ffmpeg', '~> 1.0.0'
  spec.add_runtime_dependency 'ruby-progressbar', '~> 1.7.5'
end
