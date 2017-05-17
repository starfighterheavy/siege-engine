if ENV['WEBMOCK'] == 'true'
  require 'webmock'
  include WebMock::API

  WebMock.enable!
  html = "<html><head><meta name='csrf-token' value='abc'></head><body></body></html>"
  headers = { 'set-cookie' => 'acme_session=__abc' }
  stub_request(:any, /.*/).to_return(body: html, headers: headers)
end


