lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'convert-video'

compress_video = CompressVideo.new(
  source_folder: '/source/',
  destination_folder: '/destination/',
  temp_folder: '/tmp/'
)

compress_video.inspect

compress_video.run
