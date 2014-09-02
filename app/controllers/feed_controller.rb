class FeedController < ApplicationController
  def ical
    user = User.uuid(params[:uid])
    @settings = user.ical_settings

    start_date = @settings.start_offset.seconds.from_now
    end_date = @settings.end_offset.seconds.from_now
    @episodes = user.episodes
    .includes(:series)
    .aired_between(start_date, end_date)

    data = render_to_string layout: false
    send_data data, filename: 'tvdbfeeder.ics'
  end
end
