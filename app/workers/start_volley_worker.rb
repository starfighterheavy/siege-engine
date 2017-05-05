class StartVolleyWorker < BaseWorker
  def perform(volley_id)
    @volley = Volley.find(volley_id)
    update_status('launching')
    begin
      launch!
      update_status('launched')
    rescue Exception => e
      logger.error e.to_s
      update_status('failed')
    end
  end

  def launch!
    @volley.strike_queue.each do |strike|
      StrikeWorker.perform_async(strike, @volley.id)
    end
  end

  def update_status(status)
    logger.info "Volley ##{@volley.id} #{status}"
    @volley.update_attribute(:status, status)
  end
end
