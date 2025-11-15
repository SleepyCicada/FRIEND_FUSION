class AddFieldsToAiMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :ai_messages, :ai_chat, null: false, foreign_key: true
    add_reference :ai_messages, :user, null: false, foreign_key: true
    add_column :ai_messages, :sender_type, :integer
    add_column :ai_messages, :content, :text
  end
end
