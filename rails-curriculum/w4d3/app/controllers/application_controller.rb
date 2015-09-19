class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def login_user!
    session[:session_token] = @user.session_token
    redirect_to cats_url
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def redirect_if_logged_in
    redirect_to cats_url if current_user
  end
end
