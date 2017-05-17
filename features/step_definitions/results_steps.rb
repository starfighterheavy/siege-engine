Then(/^I expect to see (\d+) results with "(.*)"$/) do |count, json_path|
  steps %Q{
    Given I have an authenticated JSON API request
    When I send a GET request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/results"
    Then the response status should be "200"
    And the JSON response should have #{count} elements matching "#{json_path}"
  }
end
