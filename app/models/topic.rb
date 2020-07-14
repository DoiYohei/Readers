class Topic < ApplicationRecord
  validates :user_id, presence: true
  validates :description, presence: true
  validates :book_tittle, presence: true
  validates :author, presence: true
  
  belongs_to :book
  
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  
  has_many :notificationds, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :favor_users, through: :likes, source: :user
  
  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and topic_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notification.new(
        topic_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.vistor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def favor(user)
    likes.create(user_id: user.id)
  end
  
  def unfavor(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  def favor?(user)
    favor_users.include?(user)
  end
end