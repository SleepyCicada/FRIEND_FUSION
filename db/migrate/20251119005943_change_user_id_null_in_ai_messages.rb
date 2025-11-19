class ChangeUserIdNullInAiMessages < ActiveRecord::Migration[7.1]
  def change
    change_column_null :ai_messages, :user_id, true
  end
end
