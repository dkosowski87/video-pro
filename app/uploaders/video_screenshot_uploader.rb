class VideoScreenshotUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/videos/#{model.video.id}/screenshots"
  end

  def extension_whitelist
    %w(jpg)
  end
end
