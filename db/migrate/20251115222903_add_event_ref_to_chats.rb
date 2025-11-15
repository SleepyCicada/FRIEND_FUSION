class AddEventRefToChats < ActiveRecord::Migration[7.1]
  def change
    add_reference :chats, :event, null: false, foreign_key: true
  end
end
