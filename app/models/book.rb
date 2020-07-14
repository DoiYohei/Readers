class Book < ApplicationRecord
  validates :book_tittle, presence: true
  validates :author, presence: true
  
  has_many :topics
end
