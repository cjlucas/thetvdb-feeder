class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @user = User.uuid(session[:uuid]) unless session[:uuid].nil?
    if @user.nil?
      redirect_to login_path
    else
      redirect_to dashboard_path
    end
  end
end
