class FeedController < ApplicationController
  def ical
    user = User.where(tvdb_id: params[:tvdb_id]).first
    ical = Icalendar::Calendar.new
    episodes = user.episodes
                .includes(:series)
                .where('airdate > ?', DateTime.now)

    episodes.each do |ep|
      next if ep.airdate.nil?

      event = Icalendar::Event.new
      event.summary = ep.series.name
      event.dtstart = Icalendar::Values::DateTime.new(episode_start_time(ep),
                                                      'tzid' => 'US/Eastern')
      event.dtend = Icalendar::Values::DateTime.new(episode_end_time(ep),
                                                    'tzid' => 'US/Eastern')
      event.location = format('%s (%.2dx%.2d)',
                              ep.name, ep.season_num, ep.episode_num)

      event.uid = UUIDTools::UUID.md5_create(UUIDTools::UUID_DNS_NAMESPACE,
                                             ep.tvdb_id.to_s).to_s
      ical.events << event
    end

    render plain: ical.to_ical
  end

  private

  def airtime_to_secs(airtime)
    time = Chronic.parse(airtime)
    (time.hour * 60 * 60) + (time.min * 60) + time.sec
  end

  def episode_start_time(episode)
    episode.airdate.to_time + airtime_to_secs(episode.series.airtime)
  end

  def episode_end_time(episode)
    episode_start_time(episode) + (episode.series.runtime * 60)
  end
end
