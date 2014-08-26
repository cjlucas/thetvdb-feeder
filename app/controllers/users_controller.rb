class UsersController < ApplicationController
  def new
    @user = User.create(tvdb_id: params[:id])
    Resque.enqueue(FetchUsersFavoritesJob, @user)
    session[:uuid] = @user.uuid
    session[:new_user] = true
    redirect_to root_path
  end

  def refresh
    flash[:alert] = 'Your feeds are currently being refreshed.'
    Resque.enqueue(FetchUsersFavoritesJob, current_user)
    Resque.enqueue(RefreshSeriesJob)
    redirect_to dashboard_path
  end

  def update_settings
    @user = User.uuid(session[:uuid])

    if params.has_key?('ical_start_offset')
      @user.ical_settings.start_offset = params['ical_start_offset']
    elsif params.has_key?('ical_end_offset')
      @user.ical_settings.end_offset = params['ical_end_offset']
    elsif params.has_key?('ical_timezone')
      @user.ical_settings.timezone = params['ical_timezone']
    elsif params.has_key?('ical_adjust_airtime')
      @user.ical_settings.adjust_airtime = params['ical_adjust_airtime']
    end

    @user.ical_settings.save

    head 200
  end

  private

  def current_user
    @current_user ||= User.uuid(session[:uuid])
  end
end
