class ChangeVideoReportsRef < ActiveRecord::Migration[5.1]
  def change
    remove_reference :video_reports, :video, index: true
    add_reference :video_reports, :video_file, index: true, foreign_key: true
  end
end
