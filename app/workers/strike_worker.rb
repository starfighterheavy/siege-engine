require 'crsf_helper'

class StrikeWorker < BaseWorker
  include CrsfHelper

  MAX_LOGIN_DELAYS = 5
  LOGIN_DELAY = 5

  def run
    logger.info "Performing strike on ##{target.id} - #{target.url}"
    make_request
    logger.info "Strike on ##{target.id} completed #{@result.code} in #{@result.time} ms"
  end

  def make_request
    attacker.with_lock do
      http = Net::HTTP.start(uri.host, uri.port)
      start_time = Time.now
      response = http.request request
      http.finish
      elapsed_time = (Time.now - start_time) * 1000
      attacker.cookie = parse_cookie(response)
      attacker.save
      @result = Result.create!(target: target, code: response.code, time: elapsed_time, volley: volley)
    end
  end

  def request
    req = Net::HTTP::Get.new(uri)
    req['Cookie'] = cookie if target.authenticated
    req
  end

  def uri
    URI.parse(target.url)
  end

  def target
    @target ||= Target.find(opts[:target_id])
  end

  def attacker
    @attacker ||= target.attacker
  end

  def volley
    @volley ||= Volley.find(opts[:volley_id])
  end

  def cookie
    attacker.cookie || Session.login(attacker, logger)
  end

  class Session
    include CrsfHelper

    def self.login(attacker, logger)
      new(attacker, logger).login
    end

    def initialize(attacker, logger)
      @attacker = attacker
      @logger = logger
    end

    def logger
      @logger
    end

    def attacker
      @attacker
    end

    def login
      logger.info "Starting fresh login for Attacker ##{attacker.id}"
      cookie, token = get_fresh_cookie_and_token(attacker.new_session_url)
      uri = URI.parse(attacker.create_session_url)
      http = Net::HTTP.start(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri)
      req['Cookie'] = cookie
      req.set_form_data(login_params.merge(authenticity_token: token))
      response = http.request(req)
      http.finish
      logger.info "Successful fresh login for Attacker ##{attacker.id}"
      parse_cookie(response)
    end

    def login_params
      {
        attacker.username_field => attacker.username,
        attacker.password_field => attacker.password
      }
    end
  end
end
