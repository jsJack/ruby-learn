class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 256 }
  validates :content, presence: true, length: { maximum: 5120 }
end
