class AddFieldsToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :name, :string
    add_column :events, :description, :text
    add_column :events, :location, :string
    add_column :events, :date, :date
    add_column :events, :time, :time
  end
end
