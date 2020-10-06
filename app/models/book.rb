class Book < ApplicationRecord
  validates :book_tittle, presence: true
  validates :author, presence: true
  
  has_many :topics
  
  def self.search(search)
    return Book.all unless search
    Book.where(['book_tittle LIKE ?', "%#{search}%"])
  end
end