class UsersController < ApplicationController

  def new 
  end


  def create 
    @user = User.new(user_params) 
    if @user.save 
      session[:session_token] = @user.reset_session_token! 
      redirect_to users_url 
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

  end

  private 
  def user_params
    params.require(:user).premit(:username, :password) 
  end

end