class StartVolleyWorker < BaseWorker
  def run
    update_status('launching')
    #begin
      launch!
      update_status('launched')
    #rescue Exception => e
      #logger.error e.to_s
      update_status('failed')
    #end
  end

  def volley
    @volley ||= Volley.find(opts[:volley_id])
  end

  def launch!
    volley.target_queue.each do |target_id|
      StrikeWorker.call({ target_id: target_id, volley_id: volley.id })
    end
  end

  def update_status(status)
    logger.info "Volley ##{volley.id} #{status}"
    volley.update_attribute(:status, status)
  end
end
