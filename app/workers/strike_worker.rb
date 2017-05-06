class StrikeWorker < BaseWorker
  def perform(target_id, volley_id)
    @target_id = target_id
    @volley_id = volley_id
    logger.info "Performing strike on ##{target_id} - #{target.url}"
    login_if_needed!
    make_request!
    register_result!
    logger.info "Strike on ##{target_id} complete in #{elapsed_time} ms"
  end

  def elapsed_time
    (@end_time - @start_time) * 1000
  end

  def attacker
    @attacker ||= target.attacker
  end

  def lock_attacker
    attacker.lock!
    attacker.locked_at = Time.now
    attacker.save!
  end

  def login_if_needed!
    return unless target.authenticated?
    return unless attacker.cookies
    while attacker.locked_at?
      sleep 5
      attacker.reload
      return if attacker.cookies
    end
    lock_attacker
    LoginWorker.new.perform(attacker.id)
    attacker.reload
  end

  def cookies
    target.cookies if target.authenticated
  end

  def response
    @response
  end

  def make_request!
    start_tracking!
    @response = Net::HTTP.get_response(uri, 'Cookie' => cookies)
    end_tracking!
  end

  def target
    @target ||= Target.find(@target_id)
  end

  def volley_id
    @volley_id
  end

  private def register_result!
    Result.create!(target_id: target.id, code: response.code, time: elapsed_time, volley_id: volley_id)
  end

  private def uri
    uri = URI.parse(target.url)
  end

  private def start_tracking!
    @start_time = Time.now
  end

  private def end_tracking!
    @end_time = Time.now
  end
end
