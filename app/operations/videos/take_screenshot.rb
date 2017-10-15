module Videos
  class TakeScreenshot < BaseOperation
    def initialize(transcoder: Transcoder.new)
      @transcoder = transcoder
    end

    def call(video)
      take_video_screenshot(video) do |file|
        persist_screenshot(video, file)
      end
      Status.success(video)
    rescue Transcoder::TranscodingFailed => e
      Status.failed(e)
    end

    private

    attr_reader :transcoder

    def take_video_screenshot(video)
      transcoder.screenshot(
        input: video.original_file.file.current_path,
        filename: filename(video)
      ) { |file| yield(file) }
    end

    def filename(video)
      File.basename(video.original_file.file_identifier, '.*')
    end

    def persist_screenshot(video, file)
      VideoScreenshot.create!(video: video, file: file)
    end
  end
end
