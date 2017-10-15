class VideoScreenshot < ApplicationRecord
  mount_uploader :file, VideoScreenshotUploader

  belongs_to :video
end
