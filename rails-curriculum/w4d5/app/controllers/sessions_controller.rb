class SessionsController < ApplicationController
  before_action :ensure_not_logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    ) #can't find by user params becasue needs to check password_digest
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new #redirecting would lose all information, user controller still alive
    end
  end

  def destroy
    logout! #dont need to pass user as arg because all controllers has access to current_user
    redirect_to new_session_url
  end
end
