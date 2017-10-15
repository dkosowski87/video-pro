class VideoDecorator < Draper::Decorator
  delegate_all

  def main_screenshot_file
    object.main_screenshot.file
  end

  def duration_in_minutes
    return '00:00' unless object.finished?
    duration = object.processed_file.video_report.duration
    Time.at(duration.to_f.ceil).utc.strftime("%M:%S")
  end

  def in_progress
    'In progress...'
  end
end
