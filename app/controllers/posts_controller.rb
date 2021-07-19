require 'date'
class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  before_action :authenticate_user!, only: [:edit, :update, :destory, :new]
  # GET /posts or /posts.json
  def index
    @posts = Post.order('publish_at DESC')
  end

  def my_post
    #@posts = Post.order('publish_at DESC')

    #user = current_user.posts.find_by(id: params[:id])
    user = User.find(current_user.id)
    @posts = user.posts.order('publish_at DESC')
  end

  # GET /posts/1 or /posts/1.json
  def show
    authorize! :update, @post
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    authorize! :update, @post
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    # username = current_user.email.split("@")
    respond_to do |format|
      @post.name = current_user.username
      #@post.publish_at = DateTime.now
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      
      params.require(:post).permit(:name, :title, :content, :user_id)
    end

    # def require_user
    #   @user = User.find_by_id(params[:id])
    #   redirect_to new_user_session_path if !@user.nil?
    # end
end
