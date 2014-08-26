class DashboardController < ApplicationController
  before_action :require_login

  def index
  end

  def statistics
    render partial: 'dashboard/statistics'
  end

  private

  def require_login
    redirect_to login_path if current_user.nil?
  end

  def current_user
    @current_user ||= User.uuid(session[:uuid]) unless session[:uuid].nil?
  end
end
