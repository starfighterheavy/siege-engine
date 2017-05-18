Given(/^I have a Volley with: '(.*)'$/) do |volley|
  steps %Q{
    Given I have an authenticated JSON API request
    When I set JSON request body to:
    """
    {
      "volley": #{volley}
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "volley_id"
  }
end

Given('I have a Volley') do
  steps %Q{
    Given I have a Volley with: '{ "name": "joe", "strikes": 100 }'
  }
end

Then(/^the status of the Volley should be '(.*)' and there should be (\d+) results$/) do |status, count|
  steps %Q{
    Given I have an authenticated JSON API request
    When I send a GET request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys/{volley_id}"
    Then the response status should be "200"
    And the JSON response should have "status" of type string and value "done"
    And the JSON response should have "results_count" of type numeric and value "14"
  }
end
