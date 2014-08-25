module FeedHelper
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
