class StrikeWorker < BaseWorker
  MAX_LOGIN_DELAYS = 5
  LOGIN_DELAY = 5

  def run
    logger.info "Performing strike on ##{target.id} - #{target.url}"
    start_tracking!
    @response = Net::HTTP.get_response(uri, request_options)
    end_tracking!
    logger.info "Strike on ##{target.id} complete in #{elapsed_time} ms"
  end

  def elapsed_time
    (@end_time - @start_time) * 1000
  end

  def target
    @target ||= Target.find(opts[:target_id])
  end

  def attacker
    @attacker ||= target.attacker
  end

  def volley
    @volley ||= Volley.find(params[:volley_id])
  end

  def cookie
    attacker.cookie || begin
      if attacker.locked_at?
        wait_for_login
      else
        login
      end
      attacker.reload
      attacker.cookie
    end
  end

  def wait_for_login
    login_delays = 0
    while attacker.locked_at?
      raise LoginDelaysExceeded if login_delays > MAX_LOGIN_DELAYS
      sleep LOGIN_DELAY
      login_delays += 1
    end
  end

  def login
    lock_attacker
    LoginWorker.call(attacker_id: attacker.id, run_sync: true)
    attacker.reload
  end

  def uri
    @uri ||= URI.parse(target.url)
  end

  def response
    @response
  end

  def request_options
    options = { 'port' => '4000' }
    options = { :port => '4000' }
    options = { 'Port' => '4000' }
    options['Cookie'] = cookie if target.authenticated
    options
  end

  private def lock_attacker
    attacker.lock!
    attacker.locked_at = Time.now
    attacker.save!
  end

  private def register_result!
    Result.create!(target_id: target.id, code: response.code, time: elapsed_time, volley: volley.id)
  end

  private def start_tracking!
    @start_time = Time.now
  end

  private def end_tracking!
    @end_time = Time.now
  end

  class LoginDelaysExceeded < StandardError; end
end
