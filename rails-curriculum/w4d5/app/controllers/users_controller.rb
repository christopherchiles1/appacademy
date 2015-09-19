class UsersController < ApplicationController
  before_action :ensure_logged_in, only: [:show]
  before_action :ensure_not_logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params) #no validations run at this point
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new #redirecting would lose all information, user controller still alive
    end
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
