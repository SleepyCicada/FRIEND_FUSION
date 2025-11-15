class CreateConfirmations < ActiveRecord::Migration[7.1]
  def change
    create_table :confirmations do |t|

      t.timestamps
    end
  end
end
