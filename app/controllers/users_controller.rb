class UsersController < ApplicationController
  def new
    @user = User.create(tvdb_id: params[:tvdb_id])
    Resque.enqueue(FetchUsersFavoritesJob, @user)
    render json: @user
  end

  def get
    @user = User.where(tvdb_id: params[:tvdb_id]).first
    if @user.nil?
      redirect_to action: :new
    else
      render json: @user
    end

    session[:uuid] = @user.uuid
  end

  def logout
    session[:uuid] = nil
    head 200
  end
end
