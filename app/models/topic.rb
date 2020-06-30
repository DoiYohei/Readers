class Topic < ApplicationRecord
  validates :user_id, presence: true
  validates :description, presence: true
  validates :book_tittle, presence: true
  validates :author, presence: true
  
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  
  has_many :likes, dependent: :destroy
  has_many :favor_users, through: :likes, source: :user
  
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