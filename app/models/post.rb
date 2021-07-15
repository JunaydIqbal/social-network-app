class Post < ApplicationRecord

  validates :title, presence: true
  validates :title, length: {maximum: 50}, allow_blank: false
  validates :content, presence: true
  validates :content, length: {maximum: 200}, allow_blank: false

end
