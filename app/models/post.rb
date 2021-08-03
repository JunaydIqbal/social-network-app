class Post < ApplicationRecord

  belongs_to :user
  has_many_attached :images
  has_many :post_threads, dependent: :destroy
  accepts_nested_attributes_for :post_threads, reject_if: :all_blank, allow_destroy: true
  has_many :comments, as: :commentable
  has_rich_text :body

  acts_as_votable

  validates :title, presence: true
  validates :title, length: {maximum: 50}, allow_blank: false
  validates :content, presence: true
  validates :content, length: {maximum: 1500}, allow_blank: false
  
  
  #Post.where('posts.user_id NOT IN (?)', User.pluck(:id)).delete_all

end
