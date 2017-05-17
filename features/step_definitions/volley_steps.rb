Given(/^I have a Volley created with (\d+) strikes$/) do |strikes|
  steps %Q{
    Given I have an authenticated JSON API request
    When I set JSON request body to:
    """
    {
      "volley": { "name": "joe", "strikes": #{strikes} }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "volley_id"
  }
end

Given('I have a Volley created') do
  steps %Q{
    Given I have a Volley created with 100 strikes
  }
end


