class CreateAiMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_messages do |t|

      t.timestamps
    end
  end
end
