require 'resque/tasks'

namespace :tvdb do
  # needed to add environment prerequisite for it resque:work to work properly
  task work: [:environment] do
    ENV['QUEUE'] = 'thetvdb-feeder' if ENV['QUEUE'].nil?
    Rake::Task['resque:work'].invoke
  end

  task workoff: [:environment] do
    ENV['INTERVAL'] = '0'
    Rake::Task['tvdb:work'].invoke
  end

  # ripped and modified from resque/tasks
  task workers: [:environment] do
    threads = []

    ENV['COUNT'].to_i.times do
      threads << Thread.new do
        system 'rake tvdb:work'
      end
    end

    threads.each { |thread| thread.join }
  end

  task refresh_user_favorites: :environment do
    User.all.each { |user| FetchUsersFavoritesJob.perform(user) }
  end

  task refresh_series: :environment do
    Series.all.each { |series| FetchSeriesJob.perform(series) }
  end

  task refresh: [:refresh_user_favorites, :refresh_series]

  task purge_old_episodes: :environment do
    Episode.destroy_all(['airdate < ?', 3.months.ago])
  end

  task maintenance: [:purge_old_episodes]
end