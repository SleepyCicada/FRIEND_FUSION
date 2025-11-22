class RemoveExtraColumnsFromEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :name, :string
    remove_column :events, :location, :string
    remove_column :events, :date, :date
    remove_column :events, :time, :time
    remove_column :events, :level, :string
    remove_column :events, :image_filename, :string
  end
end
