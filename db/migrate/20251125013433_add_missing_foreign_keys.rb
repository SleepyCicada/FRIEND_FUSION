class AddMissingForeignKeys < ActiveRecord::Migration[7.1]
  def change
    # Add user reference to events (event creator)
    add_reference :events, :user, foreign_key: true

    # Add foreign keys to confirmations (join table for users and events)
    add_reference :confirmations, :user, foreign_key: true
    add_reference :confirmations, :event, foreign_key: true

    # Add foreign keys to feedbacks
    add_reference :feedbacks, :user, foreign_key: true
    add_reference :feedbacks, :event, foreign_key: true
    add_column :feedbacks, :rating, :integer
    add_column :feedbacks, :comment, :text

    # Add foreign key to notifications
    add_reference :notifications, :user, foreign_key: true
    add_column :notifications, :message, :text
    add_column :notifications, :read, :boolean, default: false
  end
end
