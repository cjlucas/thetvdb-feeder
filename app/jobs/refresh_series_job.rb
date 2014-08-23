class RefreshSeriesJob
  def self.queue
    'thetvdb-feeder'
  end

  def self.perform
    new.work
  end

  def work
    series = []
    User.includes(:series).all.each do |user|
      user.series.all.each { |s| series << s unless series.include?(s) }
    end

    series.each { |series| Resque.enqueue(FetchSeriesJob, series) }
  end
end