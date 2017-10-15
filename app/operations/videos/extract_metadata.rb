module Videos
  class ExtractMetadata < BaseOperation
    def initialize(data_reader: MetadataReader.new)
      @data_reader = data_reader
    end

    def call(video)
      video.video_files.each do |video_file|
        video_metadata = extract_video_metadata(video_file)
        create_video_report(video_file, video_metadata)
      end
      Status.success(video)
    end

    private

    attr_reader :data_reader

    def extract_video_metadata(video_file)
      data_reader.extract(file_path: video_file.file.current_path)
    end

    def create_video_report(video_file, data)
      VideoReport.create(
        duration: data.duration,
        size: data.size,
        resolution: data.resolution,
        bit_rate: data.bit_rate,
        frame_rate: data.frame_rate,
        video_file: video_file
      )
    end
  end
end
