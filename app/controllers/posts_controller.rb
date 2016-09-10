class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :edit, :destroy, :upvote, :downvote]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    if current_user
      @post = current_user.posts.build
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
  end

  def destroy
    if @post.delete
      redirect_to posts_path  
    end
  end

  def upvote
    @post.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
    @post.downvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link_url, :body)
  end
end
