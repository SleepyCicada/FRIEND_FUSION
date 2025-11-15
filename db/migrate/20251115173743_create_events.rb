class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|

      t.timestamps
    end
  end
end
