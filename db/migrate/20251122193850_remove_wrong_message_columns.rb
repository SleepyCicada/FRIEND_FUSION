class RemoveWrongMessageColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :default, :string
    remove_column :messages, :false, :string
  end
end
