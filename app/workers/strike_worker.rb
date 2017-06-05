require 'csrf_helper'

class StrikeWorker < BaseWorker
  include CsrfHelper

  MAX_LOGIN_DELAYS = 5
  LOGIN_DELAY = 5

  def run
    logger.info "Performing strike on ##{target.id} - #{target.url}"
    make_request
    logger.info "Strike on ##{target.id} completed #{@result.code} in #{@result.time} ms"
  end

  def make_request
    attacker.with_lock do
      begin
        http = net_http_start(uri)
        start_time = Time.now
        response = http.request request
        http.finish
        elapsed_time = (Time.now - start_time) * 1000
        if target.authenticated && response.code.to_i < 300
          if ENV.fetch('DB_REFRESH'){ false }
            attacker.cookie = parse_cookie(response)
          elsif cookie != attacker.cookie
            attacker.cookie = cookie
          end
          attacker.registration_required = false
          attacker.save
        end
        @result = Result.create!(target: target, code: response.code, time: elapsed_time, volley: volley)
      rescue StandardError => e
        create_access_failure_result(e)
      end
    end
    sleep volley.delay
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
    @target ||= Target.find(opts['target_id'])
  end

  def attacker
    @attacker ||= target.attacker
  end

  def volley
    @volley ||= Volley.find(opts['volley_id'])
  end

  def cookie
    @cookie ||= attacker.cookie || begin
      if attacker.registration_required?
        Registration.create(attacker, logger)
      else
        Session.login(attacker, logger)
      end
    end
  end

  class NewSessionFailure < StandardError; end

  class CreateSessionFailure < StandardError; end

  class NewRegistrationFailure < StandardError; end

  class CreateRegistrationFailure < StandardError; end

  ERROR_CODES = {
    NewSessionFailure => 2000,
    CreateSessionFailure => 3000,
    NewRegistrationFailure => 4000,
    CreateRegistrationFailure => 5000,
    Errno::ECONNREFUSED => 1000
  }

  private def create_access_failure_result(error)
    ERROR_CODES.each do |error_class, code|
      next unless error.is_a? error_class
      logger.fatal error.to_s
      @result = Result.create!(target: target, code: code, time: nil, volley: volley)
      break
    end
    raise error
  end

  class Registration
    include CsrfHelper

    def self.create(attacker, logger)
      new(attacker, logger).register
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

    def register
      logger.info "Starting fresh registration for Attacker ##{attacker.id}"
      begin
        http = net_http_start(uri)
        response = http.request(request)
        http.finish
        check_response_code(response, 302)
      rescue StandardError => e
        raise CreateSessionFailure.new(e)
      end

      logger.info "Successful fresh registration for Attacker ##{attacker.id}"
      parse_cookie(response)
    end

    def uri
      URI.parse(attacker.create_registration_url)
    end

    def request
      req = Net::HTTP::Post.new(uri)
      req['cookie'] = session[:cookie]
      req.set_form_data(params.merge(authenticity_token: session[:token]))
      req
    end

    def params
      attacker
        .registration_form_values # a[b]=c&d[e]=f
        .split('&') # ['a[b]=c', 'd[e]=f']
        .map{ |field| field.split('=') } # [['a[b]', 'c'], ['d[e]', 'f']]
        .to_h
    end

    def session
      @session ||= begin
        begin
          get_fresh_session(attacker.new_registration_url)
        rescue StandardError => e
          raise NewRegistrationFailure.new(e)
        end
      end
    end
  end

  class Session
    include CsrfHelper

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
      begin
        cookie, token = get_fresh_cookie_and_token(attacker.new_session_url)
      rescue StandardError => e
        raise NewSessionFailure.new(e)
      end

      begin
        http = net_http_start(uri)
        response = http.request(login_request(cookie, token))
        http.finish
        check_response_code(response, 302)
      rescue StandardError => e
        raise CreateSessionFailure.new(e)
      end

      logger.info "Successful fresh login for Attacker ##{attacker.id}"
      parse_cookie(response)
    end

    def uri
      URI.parse(attacker.create_session_url)
    end

    def login_request(cookie, token)
      req = Net::HTTP::Post.new(uri)
      req['cookie'] = cookie
      req.set_form_data(login_params.merge(authenticity_token: token))
      req
    end

    def login_params
      {
        attacker.username_field => attacker.username,
        attacker.password_field => attacker.password
      }
    end
  end
end
