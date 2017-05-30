class BaseWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def self.call(opts)
    if sidekiq_enabled? && opts[:run_sync] != false
      perform_async(opts)
    else
      new.perform(opts)
    end
  end

  def perform(opts)
    @opts = opts
    run
  end

  def opts
    @opts
  end

  def run
    raise 'Abstract worker - must override perform method.'
  end

  def self.sidekiq_enabled?
    ENV['SIDEKIQ'] != 'false'
  end
end
