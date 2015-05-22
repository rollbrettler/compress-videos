require 'fileutils'
require 'streamio-ffmpeg'
require 'ruby-progressbar'

class ConvertVideo
  attr_reader :source_folder,
              :destination_folder,
              :temp_folder,
              :file_path,
              :file_name,
              :temp_file_path,
              :destination_file_path

  SEPARATOR_LINE = '==========================================='

  def initialize(args = {})
    @source_folder = args[:source_folder]
    @destination_folder = args[:destination_folder]
    @temp_folder = args[:temp_folder]
    find_file_to_convert
    define_temporary_and_destination_path
  end

  def inspect
    puts SEPARATOR_LINE
    puts "Source folder: #{source_folder}"
    puts "Destination folder: #{destination_folder}"
    puts "Temp folder: #{temp_folder}"
    puts SEPARATOR_LINE
    puts "File path: #{file_path}"
    puts "File name: #{file_name}"
    puts SEPARATOR_LINE
    puts "Temporary file path: #{temp_file_path}"
    puts "Destination file path: #{destination_file_path}"
    puts SEPARATOR_LINE
  end

  def run
    create_temp_folder
    move_file_to_temp_path
    create_destination_folder
    compress_file
  end

  private

  def temporary_file_present?
    Dir["#{temp_folder}**/*.mkv"].first.present?
  end

  def find_file_to_convert
    @file_path = Dir["#{source_folder}**/*.mkv"].first || ''
    @file_name = file_path.split(%r{\/}).last || ''
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

  def compress_file
    @progressbar = ProgressBar.create(progress_bar_settings)
    movie = FFMPEG::Movie.new(temp_file_path)
    if movie.valid?
      movie.transcode(destination_file_path,  custom: '-map 0 -c:v libx264 -c:a copy -c:s copy') do |progress|
        progressbar.progress = progress.to_f * 100
      end
    else
      revert_file_move
    end
  rescue
    revert_file_move
  end
end
