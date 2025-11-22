class AddTopicNameAndTopicDescriptionToTopics < ActiveRecord::Migration[7.1]
  def change
    add_column :topics, :topic_name, :string
    add_column :topics, :topic_description, :text
  end
end
