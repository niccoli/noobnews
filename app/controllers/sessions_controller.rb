class SessionsController < ApplicationController

  def create
    @user = User.find_by_user_name(params[:user_name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/', notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', notice: "Logged Out!"
  end
end