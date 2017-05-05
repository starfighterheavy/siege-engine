class BaseWorker
  include Sidekiq::Worker

  def perform
    raise 'Abstract worker - must override perform method.'
  end
end
