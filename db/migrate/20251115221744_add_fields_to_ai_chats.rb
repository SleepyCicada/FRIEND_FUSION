class AddFieldsToAiChats < ActiveRecord::Migration[7.1]
  def change
    add_reference :ai_chats, :user, null: false, foreign_key: true
    add_column :ai_chats, :language_target, :string
    add_column :ai_chats, :persona, :string
  end
end
