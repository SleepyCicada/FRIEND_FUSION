class AddFieldToAiChats < ActiveRecord::Migration[7.1]
  def change
    add_column :ai_chats, :settings, :json
  end
end
