require 'fileutils'
require 'streamio-ffmpeg'

class CompressVideo
  attr_accessor :source_folder, :destination_folder, :temp_folder, :file_path, :file_name, :temp_file_path, :destination_file_path

  SEPARATOR_LINE = "==========================================="

  def initialize args
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    find_file_to_convert
    define_temporary_and_destination_path
  end

  def inspect
    puts "Source folder: #{source_folder}"
    puts "Destination folder: #{destination_folder}"
    puts "Temp folder: #{temp_folder}"
    puts SEPARATOR_LINE
    puts "File path: #{file_path}"
    puts "File name: #{file_name}"
    puts SEPARATOR_LINE
    puts "Temporary file path: #{temp_file_path}"
    puts "Destination file path: #{destination_file_path}"
  end

  def run
    create_temp_folder
    move_file_to_temp_path
    create_destination_folder
    compress_file
  end

  private

  def find_file_to_convert
    @file_path = Dir["#{source_folder}**/*.mkv"].first || ""
    @file_name = file_path.split(/\//).last || ""
  end

  def define_temporary_and_destination_path
    @temp_file_path = file_path.gsub(source_folder, temp_folder)
    @destination_file_path = destination_folder + file_path.gsub(source_folder, "")
  end

  def move_file_to_temp_path
    FileUtils.mv(file_path, temp_file_path)
  end

  def create_destination_folder
    FileUtils.mkdir_p destination_file_path.gsub(file_name, "")
  end

  def create_temp_folder
    FileUtils.mkdir_p temp_file_path.gsub(file_name, "")
  end

  def compress_file
    movie = FFMPEG::Movie.new(temp_file_path)
    if(movie.valid?)
      movie.transcode(destination_file_path, { custom: "-map 0 -c:v libx264 -c:a copy -c:s copy" })
    else
      FileUtils.mv(temp_file_path, file_path)
    end
  end
end
