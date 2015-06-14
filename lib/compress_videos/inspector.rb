module CompressVideos
  module Inspector
    SEPARATOR_LINE = '==========================================='

    def inspect
      inspect_input_paths
      inspect_file_path
      inspect_output_paths
    end

    private

    def inspect_input_paths
      puts SEPARATOR_LINE
      puts "Source folder: #{source_folder}"
      puts "Destination folder: #{destination_folder}"
      puts "Temp folder: #{temp_folder}"
    end

    def inspect_file_path
      puts SEPARATOR_LINE
      puts "File path: #{file_path}"
      puts "File name: #{file_name}"
    end

    def inspect_output_paths
      puts SEPARATOR_LINE
      puts "Temporary file path: #{temp_file_path}"
      puts "Destination file path: #{destination_file_path}"
    end
  end
end
