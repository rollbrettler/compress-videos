require 'fileutils'
require 'streamio-ffmpeg'
require 'ruby-progressbar'
require 'compress_videos/compressor/ffmpeg'
require 'compress_videos/models/video'
require 'logger'

module CompressVideos
  # Compressor class that takes 3 folder paths as parameter
  # and moves the first video to a temporary folder, compresses
  # this file and moves it to the destination
  class Compressor
    def initialize(source_folder:, destination_folder:, temp_folder:, compressor: CompressVideos::Ffmpeg)
      @video = CompressVideos::Video.new(source_folder: source_folder,
                                         destination_folder: destination_folder,
                                         temp_folder: temp_folder)
      @logger ||= Logger.new(STDOUT)
      @compressor = compressor.new(@video)
    end

    def run
      prepare_folder
      move_file_to_temp_path
      @compressor.compress
      @logger.info("Finished transcoding of #{@video.destination_file_path}")
    rescue => error
      @logger.info(error)
      revert_file_move
    end

    def revert_file_move
      @logger.info("#{@video.temp_file_path} --> #{@video.file_path}")
      FileUtils.mv(@video.temp_file_path, @video.file_path)
    end

    private

    def prepare_folder
      create_destination_folder
      create_temp_folder
    end

    def move_file_to_temp_path
      @logger.info("#{@video.file_path} --> #{@video.temp_file_path}")
      FileUtils.mv(@video.file_path, @video.temp_file_path)
    end

    def create_destination_folder
      FileUtils.mkdir_p(@video.destination_file_path.gsub(@video.file_name, ''))
    end

    def create_temp_folder
      FileUtils.mkdir_p(@video.temp_file_path.gsub(@video.file_name, ''))
    end
  end
end
