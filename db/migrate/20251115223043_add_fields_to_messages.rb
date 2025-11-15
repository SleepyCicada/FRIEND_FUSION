class AddFieldsToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :user, null: false, foreign_key: true
    add_reference :messages, :chat, null: false, foreign_key: true
    add_column :messages, :message_text, :text
  end
end
