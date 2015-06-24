lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'version'

task default: %w(syntax rspec rubocop reek)
task build: %w(build_binaries build_docker_image)

task :syntax do
  sh 'ruby -c **/*.rb'
end

task :rspec do
  sh 'rspec spec/'
end

task :rubocop do
  sh 'rubocop .'
end

task :reek do
  sh 'reek .'
end

task :build_binaries do
  sh 'docker build -f build.Dockerfile -t="build-binaries" .'
  sh "docker run --rm --env VERSION=#{CompressVideos::VERSION} -v $(pwd)/build:/build -v $(pwd)/ffmpeg_build:/ffmpeg_build build-binaries"
end

task :build_docker_image do
  sh 'docker build -t="rollbrettler/compress-videos" .'
  # sh 'docker save rollbrettler/compress-videos > ./image/compress-videos.tar'
end
