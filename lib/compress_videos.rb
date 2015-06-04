require 'fileutils'
require 'streamio-ffmpeg'
require 'ruby-progressbar'
require 'compress_video/inspector'

module CompressVideos
  # Compressor class that takes 3 folder paths as parameter
  # and moves the first video to a temporary folder, compresses
  # this file and moves it to the destination
  class Compressor
    extend CompressVideos::Inspector
    attr_reader :source_folder,
                :destination_folder,
                :temp_folder,
                :file_path,
                :file_name,
                :temp_file_path,
                :destination_file_path

    def initialize(args = {})
      @source_folder = args[:source_folder]
      @destination_folder = args[:destination_folder]
      @temp_folder = args[:temp_folder]
      find_file_to_compress
      define_temporary_and_destination_path
    end

    def run
      create_temp_folder
      move_file_to_temp_path
      create_destination_folder
      compress_video
    end

    private

    def temporary_file_present?
      Dir["#{temp_folder}**/*.mkv"].first.present?
    end

    def find_file_to_compress
      @file_path = Dir["#{source_folder}**/*.mkv"].first || ''
      @file_name = File.basename(file_path) || ''
    end

    def define_temporary_and_destination_path
      @temp_file_path = temp_folder + file_name
      @destination_file_path = destination_folder + file_path.gsub(source_folder, '')
    end

    def move_file_to_temp_path
      FileUtils.mv(file_path, temp_file_path)
    end

    def create_destination_folder
      FileUtils.mkdir_p destination_file_path.gsub(file_name, '')
    end

    def create_temp_folder
      FileUtils.mkdir_p temp_file_path.gsub(file_name, '')
    end

    def revert_file_move
      FileUtils.mv(temp_file_path, file_path)
    end

    def progress_bar_settings
      {
        title: 'Progress',
        format: '%a %bᗧ%i %p%% %t',
        progress_mark: ' ',
        remainder_mark: '･'
      }
    end

    def compress_video
      movie = FFMPEG::Movie.new(temp_file_path)
      if movie.valid?
        transcode_video
      else
        revert_file_move
      end
    rescue
      revert_file_move
    end

    def transcode_video
      @progressbar = ProgressBar.create(progress_bar_settings)
      movie.transcode(destination_file_path,  custom: '-map 0 -c:v libx264 -c:a copy -c:s copy') do |progress|
        progressbar.progress = progress.to_f * 100
      end
    end
  end
end
