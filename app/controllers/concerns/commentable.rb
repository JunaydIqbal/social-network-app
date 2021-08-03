module Commentable
  extend ActiveSupport::Concern
  include ActionView::RecordIdentifier
  include CommentsHelper

  included do
    before_action :authenticate_user!
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    #@comment.save
    # redirect_to @comment
    # redirect_to posts_path
    respond_to do |format|
      if @comment.save
        # redirect_to posts_path
        # format.html do |variant|
        #   variant.any(:tablet, :phablet){ render html: "any" }
        #   variant.phone { render html: "phone" }
        # end
        comment = Comment.new
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(dom_id_for_records(@commentable, comment), partial: "comments/form", locals: {comment: comment, commentable: @commentable}) 
        }
        
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(dom_id_for_records(@commentable, @comment), partial: "comments/form", locals: {comment: @comment, commentable: @commentable}) 
        }
        format.html {redirect_to @commentable}
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Comment was successfully Deleted!" }
      format.json { head :no_content }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
end