class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    #Log in
    user_name = user_params[:user_name]
    password = user_params[:password]
    if @user = User.find_by_credentials(user_name, password)
      @user.reset_session_token!
      login_user!
    else
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      @current_user = nil
    end
    redirect_to cats_url
  end
end
