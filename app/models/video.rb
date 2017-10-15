class Video < ApplicationRecord
  enum status: %i(pending processing finished)

  has_many :video_files, dependent: :destroy
  has_many :video_reports, through: :video_files
  has_many :video_screenshots, dependent: :destroy

  has_one :original_file, -> { original.order(id: :asc) }, class_name: 'VideoFile'
  has_one :processed_file, -> { processed.order(id: :desc) }, class_name: 'VideoFile'
  has_one :main_screenshot, -> { order(id: :asc) }, class_name: 'VideoScreenshot'

  scope :with_processed_file_data, -> { includes(processed_file: :video_report) }
end
