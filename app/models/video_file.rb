class VideoFile < ApplicationRecord
  mount_uploader :file, VideoFileUploader

  enum version: %i(original processed)

  belongs_to :video
  has_one :video_report
end
