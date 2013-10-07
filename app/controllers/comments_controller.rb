class CommentsController < ApplicationController
  before_filter :load_commentable

  def index
    @comments = @commentable.comments 
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comments = Comment.all
    if @comment.save
      redirect_to posts_path, notice: "Comment Created."
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