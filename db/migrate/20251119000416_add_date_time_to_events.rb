class AddDateTimeToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :date_time, :datetime
  end
end
