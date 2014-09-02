module FeedHelper
  def airtime_to_secs(airtime)
    time_s, period = airtime.downcase.split
    hours, minutes = time_s.split(':')

    time = period.eql?('pm') ? (12 * 60 * 60) : 0
    time + (hours.to_i * 60 * 60) + (minutes.to_i * 60)
  end

  def episode_start_time(episode)
    episode.airdate.to_time + airtime_to_secs(episode.series.airtime)
  end

  def episode_end_time(episode)
    episode_start_time(episode) + (episode.series.runtime * 60)
  end
end
