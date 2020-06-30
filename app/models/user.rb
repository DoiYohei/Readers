class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]{8,32}+\z/i
  validates :password, presence: true, length: { in: 8..32 }, format: { with: VALID_PASSWORD_REGEX }
  
  has_secure_password
  
  mount_uploader :user_image, ImageUploader
  
  has_many :topics
  
  has_many :likes, dependent: :destroy
  has_many :favor_topics, through: :likes, source: :topic
  
  has_many :following_relationships,foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships,foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def follow(other_user)
    self.following_relationships.create(following_id: other_user.id)
  end
  
  def unfollow(other_user)
    self.following_relationships.find_by(following_id: other_user.id).destroy
  end
end