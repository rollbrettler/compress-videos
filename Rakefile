task default: %w(syntax rspec rubocop reek)
task build: %w(build_ffmpeg_binary build_docker_image)

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

task :build_ffmpeg_binary do
  sh 'docker build -f build-ffmpeg.Dockerfile -t="build-ffmpeg" .'
  sh 'docker run -i -t --rm -v $(pwd)/build:/build build-ffmpeg'
end

task :build_docker_image do
  sh 'docker build -t="rollbrettler/convert-videos" .'
  sh 'docker save convert-videos > ./image/convert-videos.tar'
end
