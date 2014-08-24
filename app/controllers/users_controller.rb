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

  def update_settings
    @user = User.uuid(session[:uuid])

    if params.has_key?('ical_start_offset')
      puts params['ical_start_offset']
      @user.ical_settings.start_offset = params['ical_start_offset']
    elsif params.has_key?('ical_end_offset')
      @user.ical_settings.end_offset = params['ical_end_offset']
    end

    @user.ical_settings.save

    head 200
  end
end
