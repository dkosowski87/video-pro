class CreateVideoScreenshots < ActiveRecord::Migration[5.1]
  def change
    create_table :video_screenshots do |t|
      t.string :file
      t.string :description
      t.references :video, foreign_key: true, index: true
    end
  end
end
