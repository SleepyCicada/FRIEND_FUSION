class AddAiToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :ai, :boolean
    add_column :messages, :default, :string
    add_column :messages, :false, :string
  end
end
