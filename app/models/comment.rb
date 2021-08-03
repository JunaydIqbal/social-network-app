class Comment < ApplicationRecord
  include ActionView::RecordIdentifier
  belongs_to :user

  belongs_to :commentable, polymorphic: true
  has_rich_text :body

  validates_presence_of :body



  after_create_commit do
    broadcast_append_to [commentable, :comments], target: "#{dom_id(commentable)}_comments"
  end

  after_update_commit do
    broadcast_replace_to self
  end
  
  after_destroy_commit do
    broadcast_remove_to self
  end

end
