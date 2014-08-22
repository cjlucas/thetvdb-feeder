class RefreshSeriesJob
  def self.queue
    'thetvdb-feeder'
  end

  def self.perform
    new.work
  end

  def work
    Series.all.each { |series| Resque.enqueue(FetchSeriesJob, series.id) }
  end
end