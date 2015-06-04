require 'compress_videos'
require 'fakefs/spec_helpers'

RSpec.describe CompressVideos::Compressor do
  include FakeFS::SpecHelpers

  let(:file_array) do
    [
      '/source/_sort/movie/Movie1.mkv',
      '/source/_sort/movie/Movie2.mkv',
      '/source/_sort/movie/NotAMovie.jpg'
    ]
  end

  let(:compress_video) do
    described_class.new(
      source_folder: '/source/',
      destination_folder: '/destination/',
      temp_folder: '/tmp/'
    )
  end

  let(:mapper) { double('mapper') }

  before(:each) do
    allow(Dir).to receive(:glob).and_return(file_array)
  end

  it 'is a class' do
    expect(described_class.class).to equal(Class)
  end

  it 'gets 3 directory strings passed' do
    expect(compress_video.source_folder).to eq('/source/')
    expect(compress_video.destination_folder).to eq('/destination/')
    expect(compress_video.temp_folder).to eq('/tmp/')
  end

  it 'automatically finds the file name and file path' do
    expect(compress_video.file_name).to eq('Movie1.mkv')
    expect(compress_video.file_path).to eq('/source/_sort/movie/Movie1.mkv')
  end

  it 'automatically sets temporary file path' do
    expect(compress_video.temp_file_path).to eq('/tmp/Movie1.mkv')
  end

  it 'automatically sets destination file path' do
    expect(compress_video.destination_file_path).to eq('/destination/_sort/movie/Movie1.mkv')
  end
end
