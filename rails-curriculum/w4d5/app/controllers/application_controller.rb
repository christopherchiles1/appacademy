class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user #makes it available to views

  def login!(user) #need to pass in user because this controller is superclass of users_controller
    #and won't know its data
    session[:session_token] = user.reset_session_token!
  end
  #cookies are sent with every request all the time

  #can make a query because you're not in views, this controller asks model to find user
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def ensure_logged_in
    redirect_to new_session_url unless current_user
  end

  def ensure_not_logged_in
    redirect_to user_url(current_user) if current_user
  end
end
