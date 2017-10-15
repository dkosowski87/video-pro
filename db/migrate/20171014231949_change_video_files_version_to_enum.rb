class ChangeVideoFilesVersionToEnum < ActiveRecord::Migration[5.1]
  def change
    remove_column :video_files, :version
    add_column :video_files, :version, :integer
  end
end
