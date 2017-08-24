require 'net/http'

module CsrfHelper
  def net_http_start(uri)
    opts = {}
    if ENV['http_proxy']
      proxy = URI.parse(ENV['http_proxy'])
      opts[:p_addr] = proxy.host
      opts[:p_port] = proxy.port
      opts[:p_user] = proxy.user
      opts[:p_password] = proxy.password
    end
    opts[:use_ssl] = uri.port == 443
    Net::HTTP.start(uri.host, uri.port, opts[:p_addr], opts[:p_port], opts[:p_user], opts[:p_password], use_ssl: opts[:use_ssl])
  end

  def get_fresh_cookie_and_token(url)
    uri = URI.parse(url)
    http = net_http_start(uri)
    req = Net::HTTP::Get.new(uri)
    response = http.request req
    check_response_code(response)
    http.finish
    return parse_cookie(response), parse_crsf_token(response)
  end

  def get_fresh_session(url)
    uri = URI.parse(url)
    http = net_http_start(uri)
    req = Net::HTTP::Get.new(uri)
    response = http.request req
    check_response_code(response)
    http.finish
    { cookie: parse_cookie(response), token: parse_crsf_token(response) }
  end


  def parse_cookie(response)
    all_cookies = response.get_fields('set-cookie')
    cookies_array = Array.new
    all_cookies.each do |cookie|
      cookies_array.push(cookie.split('; ')[0])
    end
    cookies_array.join('; ')
  end

  def parse_crsf_token(response)
    Nokogiri::HTML(response.body)
      .xpath('//head/meta')
      .find{ |m| m.values[0] == 'csrf-token' }
      .values[1]
  end

  def check_response_code(response, expected_status = nil)
    code = response.code.to_i
    raise FailedRequest, response if code >= 400 || (expected_status && expected_status != code)
  end

  class FailedRequest < StandardError
    def initialize(response)
      msg = "Failed with code #{response.code}"
      super(msg)
    end
  end
end
