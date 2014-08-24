module ApplicationHelper
  def current_user
    @current_user ||= session[:uuid].nil? \
    ? nil : User.where(uuid: session[:uuid]).first
  end
end
