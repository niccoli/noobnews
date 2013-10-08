class CommentsController < ApplicationController
  before_filter :load_commentable

  def index
    @comments = Post.find(params[:post_id]).comments
    @post = Post.find(params[:post_id])
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comments = Comment.all
    if @comment.save
      redirect_to post_comments_path, notice: "Comment Created."
    else
      render :new
    end
  end

private
  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def comment_params  
    params.require(:comment).permit(:content)
  end
end