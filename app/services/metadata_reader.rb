class MetadataReader
  def extract(file_path:)
    metadata = extract_video_metadata(file_path)
    map_data(metadata)
  end

  private

  def extract_video_metadata(file_path)
    FFMPEG::Movie.new(file_path)
  end

  def map_data(data)
    OpenStruct.new(
      duration: data.duration,
      size: data.size,
      resolution: data.resolution,
      bit_rate: data.bitrate,
      frame_rate: data.frame_rate,
    )
  end
end
