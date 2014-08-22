class RefreshUserFavoritesJob
  def self.queue
    'thetvdb-feeder'
  end

  def self.perform
    new.work
  end

  def work
    User.all.each { |user| Resque.enqueue(FetchUsersFavoritesJob, user.id) }
  end
end