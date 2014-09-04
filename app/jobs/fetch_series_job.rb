class FetchSeriesJob
  def self.queue
    'thetvdb-feeder'
  end

  def self.perform(series_id)
    new(series_id).work
  end

  def initialize(series_id)
    series_id = series_id['id'] if series_id.is_a?(Hash)
    @series_id = series_id
  end

  def work
    series = Series.find(@series_id)
    tvdb = TvdbParty::Search.new(Rails.application.tvdb_api_key)
    tvdb_series = tvdb.get_series_by_id(series.tvdb_id)

    # create/update series
    model_args = series_model_args(tvdb_series)
    series = Series.where(tvdb_id: model_args[:tvdb_id]).first
    if series.nil?
      series = Series.create(**model_args)
    else
      Series.update(series, **model_args)
    end

    # create/update episodes
    tvdb.get_all_episodes(tvdb_series).each do |tvdb_episode|
      next if tvdb_episode.air_date.nil?
      # don't populate db with old episodes
      next if tvdb_episode.air_date < 1.month.ago

      model_args = episode_model_args(tvdb_episode)

      episode = Episode.where(tvdb_id: model_args[:tvdb_id]).first
      if episode.nil?
        episode = Episode.create(**model_args)
      else
        Episode.update(episode, **model_args)
      end

      series.episodes << episode unless series.episodes.exists?(episode)
    end
  end

  def series_model_args(tvdb_series)
    {
        tvdb_id: tvdb_series.id,
        name: tvdb_series.name,
        runtime: tvdb_series.runtime,
        airtime: tvdb_series.air_time,
    }
  end

  def episode_model_args(tvdb_episode)
    {
        tvdb_id: tvdb_episode.id,
        name: tvdb_episode.name,
        season_num: tvdb_episode.season_number,
        episode_num: tvdb_episode.number,
        airdate: tvdb_episode.air_date
    }
  end
end