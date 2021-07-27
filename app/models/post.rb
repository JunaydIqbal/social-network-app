class Post < ApplicationRecord

  belongs_to :user
  has_many_attached :images

  validates :title, presence: true
  validates :title, length: {maximum: 50}, allow_blank: false
  validates :content, presence: true
  validates :content, length: {maximum: 1500}, allow_blank: false


  #Post.where('posts.user_id NOT IN (?)', User.pluck(:id)).delete_all

end
