class AddStatusToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :status, :integer
  end
end
