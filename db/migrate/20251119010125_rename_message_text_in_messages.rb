class RenameMessageTextInMessages < ActiveRecord::Migration[7.1]
  def change
    rename_column :messages, :message_text, :content
  end
end
