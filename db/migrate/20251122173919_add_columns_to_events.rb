class AddColumnsToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :max_capacity, :integer
    add_column :events, :location, :string
    add_reference :events, :topic, foreign_key: true
  end
end
