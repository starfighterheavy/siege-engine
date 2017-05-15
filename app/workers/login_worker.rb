class LoginWorker < BaseWorker
  def run
    response = Net::HTTP.post_form(uri, login_params)
    cookies = parse_cookies(response)
    attacker.update_attribute(:cookie, cookies)
    ensure
      unlock_attacker
  end

  def crsf_token
    @crsf_token ||= begin
      uri = URI.parse(attacker.new_session_url)
      response = Net::HTTP.get_response(uri)
      parsed_body = Nokogiri::HTML(response.body)
      page.at('meta[name="crsf-token"]')['content']
    end
  end

  def uri
    @uri ||= URI.parse(attacker.create_session_url)
  end

  def attacker
    @attacker ||= Attacker.find(opts[:attacker_id])
  end

  def parse_cookies(resp)
    all_cookies = resp.get_fields('set-cookie')
    cookies_array = Array.new
    all_cookies.each do |cookie|
      cookies_array.push(cookie.split('; ')[0])
    end
    cookies_array.join('; ')
  end

  def login_params
    {
      'authenticity_token': crsf_token,
      attacker.username_field => attacker.username,
      attacker.password_field => attacker.password,
    }
  end

  def unlock_attacker
    attacker.locked_at = nil
    attacker.save!
  end
end
