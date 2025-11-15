class CreateAiChats < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_chats do |t|

      t.timestamps
    end
  end
end
