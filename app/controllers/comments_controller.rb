class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]



  
  def show
    authorize! :show, @comment
  end

  def edit
     authorize! :updates, @comment
  end

  def update
    authorize! :update, @comment
    if @comment.update(comment_params)
      redirect_to @comment
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @comment
    @comment.destroy
    respond_to do |format|
      format.turbo_stream {}
      format.html{redirect_to @comment.commentable}
    end
  end

  private

    def set_comment
      #@comment ||= current_user.comments.find(params[:id])
      #@comment = current_user.comments.find(params[:id])
      @comment = current_user.comments.find_by(id:params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end

end
