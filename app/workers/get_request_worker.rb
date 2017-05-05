require 'net/http'
require 'uri'

class GetRequestWorker < BaseWorker
  def perform(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    puts "Done! Called #{url} and got #{response.code}"
  end
end
