module CompressVideos
  class Ffmpeg
    def initialize(video_file)
      @video_file = video_file
    end

    def compress
      @movie = FFMPEG::Movie.new(@video_file.temp_file_path)
      return transcode_video if @movie.valid?
      fail 'File not valid'
    end

    private

    def progress_bar_settings
      {
        title: 'Progress',
        format: '%a %bᗧ%i %p%% %t',
        progress_mark: ' ',
        remainder_mark: '･'
      }
    end

    def transcode_video
      @progressbar = ProgressBar.create(progress_bar_settings)
      @movie.transcode(@video_file.destination_file_path, configuration) do |progress|
        @progressbar.progress = progress.to_f * 100
      end
    end

    def configuration
      { custom: '-map 0 -c:v libx264 -preset slower -c:a copy -c:s copy' }
    end
  end
end
