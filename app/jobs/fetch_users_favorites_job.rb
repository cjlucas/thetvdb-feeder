class FetchUsersFavoritesJob
  FAVORITE_SERIES_XPATH = '/Favorites/Series'

  def self.queue
    'thetvdb-feeder'
  end

  def self.perform(user_id)
    new(user_id).work
  end

  def initialize(user_id)
    user_id = user_id['id'] if user_id.is_a?(Hash)
    @user_id = user_id
  end

  def work
    user = User.includes(:series).find(@user_id)

    tvdb_ids = []
    user_favorites(user) do |tvdb_id|
      tvdb_ids << tvdb_id
      series = Series.where(tvdb_id: tvdb_id).first
      series = Series.create(tvdb_id: tvdb_id) if series.nil?
      user.series << series unless user.series.exists?(series)
      # only enqueue if series was just added to the database
      if (Time.now - series.created_at) < 10
        Resque.enqueue(FetchSeriesJob, series)
      end
    end

    # delete series if no longer in user's favorites
    p tvdb_ids.size
    user.series.each do |series|
      p series.tvdb_id
      user.series.delete(series) unless tvdb_ids.include?(series.tvdb_id)
    end

    user.scanned!
  end

  def user_favorites(user, &block)
    data = Net::HTTP.get(user_favorites_api_uri(user.tvdb_id))
    Nokogiri.parse(data).xpath(FAVORITE_SERIES_XPATH).collect do |element|
      yield element.child.text.to_i
    end
  end

  def user_favorites_api_uri(account_id)
    URI("http://thetvdb.com/api/User_Favorites.php?accountid=#{account_id}")
  end
end
