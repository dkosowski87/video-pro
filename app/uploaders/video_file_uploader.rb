class VideoFileUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/videos/#{model.video.id}/#{model.version}"
  end

  def extension_whitelist
    %w(avi mp4 mpeg)
  end
end
