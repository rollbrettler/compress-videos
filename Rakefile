lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'fileutils'
require 'version'

task default: %w(syntax spec rubocop reek)
task build: %w(build_binaries build_docker_image test_image)

task :syntax do
  sh 'ruby -c **/*.rb'
end

task :spec do
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
end

task :copy_test_file do
  FileUtils.cp('fixtures/test1.mkv', 'fixtures/src/test1.mkv')
end

task test_image: :copy_test_file do
  sh <<-sh
    docker run \
      -t \
      -i \
      --rm \
      -v $(pwd)/fixtures/src:/source \
      -v $(pwd)/fixtures/dest:/destination \
      -v $(pwd)/fixtures/tmp:/tmp \
      rollbrettler/compress-videos
    sh
end

task test_gem: :copy_test_file do
  sh 'bin/compress-videos $PWD/fixtures/src $PWD/fixtures/dest $PWD/fixtures/tmp'
end

task :release do
  sh "docker tag -f rollbrettler/compress-videos rollbrettler/compress-videos:#{CompressVideos::VERSION}"
  sh "docker save rollbrettler/compress-videos:#{CompressVideos::VERSION} > ./image/compress-videos.tar"
end
