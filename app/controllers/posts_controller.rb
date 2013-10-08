class PostsController < ApplicationController

  def index 
    @post = Post.new
    @posts = Post.all
    @vote = Vote.new
    @sort = Post.sort
    @commentable = @post
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    @posts = Post.all
    if @post.save
      flash[:notice] = "Your Post has been added."
      redirect_to posts_path
    else
      render :new
    end
  end

private

  def post_params
    params.require(:post).permit(:description, :link, :content)
  end
end 