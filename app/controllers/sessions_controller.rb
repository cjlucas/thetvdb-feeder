class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token, only: [:login]

  def index
  end

  def login
    @user = User.find_by_tvdb_id(params[:id])
    if @user.nil?
      redirect_to '/users/new', id: params[:id]
    else
      session[:uuid] = @user.uuid
      redirect_to '/'
    end
  end

  def logout
    session[:uuid] = nil
    redirect_to '/'
  end
end
