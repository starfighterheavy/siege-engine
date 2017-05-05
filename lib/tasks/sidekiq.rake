namespace :sidekiq do
  desc "clears sidekiq jobs"
  task clear: :environment do
    require 'sidekiq/api' # for the case of rails console

    Sidekiq::Queue.new.clear
    Sidekiq::RetrySet.new.clear
    Sidekiq::ScheduledSet.new.clear
    stats = Sidekiq::Stats.new
    puts 'Jobs Remaining: ' + stats.enqueued.to_s
  end
end
