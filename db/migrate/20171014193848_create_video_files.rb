class CreateVideoFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :video_files do |t|
      t.string :file
      t.string :version
      t.references :video, foreign_key: true, index: true
    end
  end
end
