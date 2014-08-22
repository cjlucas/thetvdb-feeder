class FetchUsersFavoritesJob
  FAVORITE_SERIES_XPATH = '/Favorites/Series'

  def self.queue
    'thetvdb-feeder'
  end

  def self.perform(user_id)
    new(user_id).work
  end

  def initialize(user_id)
    user_id = user_id.id if user_id.is_a?(User)
    @user_id = user_id
  end

  def work
    user = User.includes(:series).find(@user_id)
    user_favorites(user) do |series|
      user.series << series unless user.series.exists?(series)
      Resque.enqueue(FetchSeriesJob, series)
    end
  end

  def user_favorites(user, &block)
    data = Net::HTTP.get(user_favorites_api_uri(user.tvdb_id))
    Nokogiri.parse(data).xpath(FAVORITE_SERIES_XPATH).each do |element|
      tvdb_id = element.child.text
      series = Series.where(tvdb_id: tvdb_id).first
      series = Series.create(tvdb_id: tvdb_id) if series.nil?
      yield series
    end
  end

  def user_favorites_api_uri(account_id)
    URI("http://thetvdb.com/api/User_Favorites.php?accountid=#{account_id}")
  end
end