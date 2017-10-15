class RemoveFileFromVideos < ActiveRecord::Migration[5.1]
  def change
    remove_column :videos, :file
  end
end
