class VotesController < ApplicationController
  def index
    @vote = Vote.new
  end

  def create
    @vote = current_user.votes.new(vote_params)
    if @vote.save
      flash.alert = "Thank you for voting!"
      redirect_to posts_path
    else
      redirect_to posts_path
    end 
  end

private

  def vote_params
    params.require(:vote).permit(:post_id)
  end

end