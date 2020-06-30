class Like < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  counter_culture :topic
  validates :user_id, presence: true
  validates :topic_id, presence: true
  
  default_scope -> { order(created_at: :desc) }
end
