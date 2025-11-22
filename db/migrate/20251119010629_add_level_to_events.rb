class AddLevelToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :level, :string
    add_column :events, :image_filename, :string
  end
end
