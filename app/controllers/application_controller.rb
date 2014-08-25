class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def index
  #   if session[:new_user]
  #     flash[:alert] = 'Welcome! Feel free to customize your feeds ' \
  #     'while we scan your favorites list'
  #     session[:new_user] = false
  #   end
  #
  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  # end


  def index
    if session[:uuid].nil?
      redirect_to login_path
    else
      redirect_to dashboard_path
    end
  end
end
