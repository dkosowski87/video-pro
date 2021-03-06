class Transcoder
  class TranscodingFailed < StandardError; end

  def transcode(input:, filename:, &output_policy)
    execute!(input, filename, video_format, encoding_options, output_policy)
  end

  def screenshot(input:, filename:, &output_policy)
    execute!(input, filename, image_format, { screenshot: true }, output_policy)
  end

  private

  def execute!(input, filename, file_format, options, output_policy)
    input = wrap_input_data(input)
    output = build_output_path(filename, file_format)

    transcode!(input, output, options)
    expose_output_file(output, output_policy)
    clean_up_temp_file(output)
  rescue FFMPEG::Error
    raise TranscodingFailed
  end

  def wrap_input_data(input)
    input = input.to_path if input.respond_to?(:to_path)
    input = input.to_s
    FFMPEG::Movie.new(input)
  end

  def build_output_path(filename, file_format)
    "#{Rails.root.join('tmp', filename)}.#{file_format}"
  end

  def video_format
    'mp4'
  end

  def image_format
    'jpg'
  end

  def transcode!(input, output, options = {})
    FFMPEG::Transcoder.new(input, output, options, {}).run
  end

  def encoding_options
    FFMPEG::EncodingOptions.new(
      video_codec: 'h264',
      audio_codec: 'aac',
      resolution: '640x360',
      video_bitrate: 360
    )
  end

  def expose_output_file(output, output_policy)
    File.open(output) do |file|
      output_policy.call(file)
    end
  end

  def clean_up_temp_file(output)
    FileUtils.rm_rf(output)
  end
end
