lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'fileutils'
require 'version'

task default: %w(syntax rspec rubocop reek)
task build: %w(build_binaries build_docker_image test_image)

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
  sh "docker build -f build.Dockerfile -t='build-binaries:#{CompressVideos::VERSION}' ."
  sh <<-sh
    docker run \
      --rm \
      --env VERSION=#{CompressVideos::VERSION} \
      -v $(pwd)/build:/build \
      build-binaries:#{CompressVideos::VERSION}
  sh
end

task :build_docker_image do
  sh 'docker build -t="rollbrettler/compress-videos" .'
  sh 'docker save rollbrettler/compress-videos > ./image/compress-videos.tar'
  sh "docker tag rollbrettler/compress-videos rollbrettler/compress-videos:#{CompressVideos::VERSION}"
end

task :test_image do
  FileUtils.cp('fixtures/test1.mkv', 'fixtures/src/test1.mkv')
  sh <<-sh
    docker run \
      -t \
      -i \
      --rm \
      -v $(pwd)/fixtures/src:/source \
      -v $(pwd)/fixtures/dest:/destination \
      -v $(pwd)/fixtures/tmp:/tmp \
      rollbrettler/compress-videos:#{CompressVideos::VERSION}
    sh
end
