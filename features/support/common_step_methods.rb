require 'base64'
def auth_header
  "Basic #{Base64.strict_encode64([ENV['SE_ACCESS_KEY_ID'], ':', ENV['SE_SECRET_ACCESS_KEY']].join)}"
end

def previous_step_time
  return nil unless @previous_step_time
  (@current_step_time - @previous_step_time) * 1000
end

$default_headers = {
  'Authorization' => auth_header,
  'Accept' => 'application/json',
  'Content-Type' => 'application/json'
}
