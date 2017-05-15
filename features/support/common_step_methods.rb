require 'base64'
def auth_header
  "Basic #{Base64.strict_encode64([ENV['SE_ACCESS_KEY_ID'], ':', ENV['SE_SECRET_ACCESS_KEY']].join)}"
end

def create_siege(name: 'teddy')
  steps %Q{
    Given I have an authenticated JSON API request
    When I set JSON request body to:
    """
    {
      "siege": { "name": "#{name}" }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/sieges"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "siege_id"
  }
end