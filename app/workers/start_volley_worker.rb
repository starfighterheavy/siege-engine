class StartVolleyWorker < BaseWorker
  def run
    logger.info 'Initializing volley with options:'
    logger.info opts.to_s
    update_status('launching')
    launch!
    update_status('launched')
  end

  def volley
    @volley ||= Volley.find(opts['volley_id'])
  end

  def launch!
    logger.info "Launching volley for ##{opts['volley_id']}"
    volley.target_queue.each do |target_id|
      StrikeWorker.call({ "target_id" => target_id, "volley_id" => volley.id })
    end
  end

  def update_status(status)
    logger.info "Volley ##{volley.id} #{status}"
    volley.update_attribute(:status, status)
  end
end
