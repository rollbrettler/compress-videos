module CompressVideos
  class Video
    attr_reader :source_folder,
                :destination_folder,
                :temp_folder

    def initialize(source_folder:, destination_folder:, temp_folder:)
      @source_folder = source_folder
      @destination_folder = destination_folder
      @temp_folder = temp_folder
    end

    def temporary_file_present?
      Dir.glob("#{@temp_folder}**/*.mkv").first.present?
    end

    def file_path
      @file_path ||= Dir.glob("#{@source_folder}**/*.mkv").first || ''
    end

    def file_name
      @file_name ||= File.basename(file_path) || ''
    end

    def temp_file_path
      @temp_file_path ||= @temp_folder + file_name
    end

    def destination_file_path
      @destination_file_path ||= @destination_folder + file_path.gsub(@source_folder, '')
    end
  end
end
