module Videos
  class Transcode < BaseOperation
    def initialize(transcoder: Transcoder.new)
      @transcoder = transcoder
    end

    def call(video)
      transcode_video(video) do |file|
        persist_transcoded_file(video, file)
      end
      Status.success(video)
    rescue Transcoder::TranscodingFailed => e
      Status.failed(e)
    end

    private

    attr_reader :transcoder

    def transcode_video(video)
      transcoder.transcode(
        input: video.original_file.file.current_path,
        filename: filename(video)
      ) { |file| yield(file) }
    end

    def filename(video)
      File.basename(video.original_file.file_identifier, '.*')
    end

    def persist_transcoded_file(video, file)
      VideoFile.create!(video: video, file: file, version: :processed)
    end
  end
end
