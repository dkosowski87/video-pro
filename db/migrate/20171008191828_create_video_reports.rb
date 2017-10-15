class CreateVideoReports < ActiveRecord::Migration[5.1]
  def change
    create_table :video_reports do |t|
      t.string :duration
      t.string :size
      t.string :resolution
      t.string :bit_rate
      t.string :frame_rate
      t.references :video, foreign_key: true, index: true
    end
  end
end
