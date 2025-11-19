class AddTitleAndDescriptionToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :title, :string
    add_column :events, :description, :text
  end
end
