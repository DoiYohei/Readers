class AddLikesCountToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :likes_count, :integer, nil: false, default: 0
  end
end