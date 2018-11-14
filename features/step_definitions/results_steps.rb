Then(/^I expect to see (\d+) results with "(.*)"$/) do |count, json_path|
  steps %Q{
    Given I have an authenticated JSON API request
    When I send a GET request to "/api/v1/volleys/V1/results"
    Then the response status should be "200"
  }
end
