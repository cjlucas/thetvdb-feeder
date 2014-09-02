require 'resque/tasks'

namespace :tvdb do
  # needed to add environment prerequisite for it resque:work to work properly
  task work: [:environment, 'resque:work'] do
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
end