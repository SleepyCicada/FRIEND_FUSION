class RemoveDescriptionFromEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :description
  end
end
