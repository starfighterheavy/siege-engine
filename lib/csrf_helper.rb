module CsrfHelper
  def get_fresh_cookie_and_token(url)
    uri = URI.parse(url)
    http = Net::HTTP.start(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri)
    response = http.request req
    check_response_code(response)
    http.finish
    return parse_cookie(response), parse_crsf_token(response)
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

  def check_response_code(response)
    raise FailedRequest, response if response.code.to_i >= 400
  end

  class FailedRequest < StandardError
    def initialize(response)
      msg = "Failed with code #{response.code}"
      super(msg)
    end
  end
end
