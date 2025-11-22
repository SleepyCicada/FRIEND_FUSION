class AddDescriptionToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :description, :text
  end
end
