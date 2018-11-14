Given(/^I have a Volley with: '(.*)'$/) do |volley|
  steps %Q{
    When I send a POST request to "/api/v1/sieges/S1/volleys" with the following:
    """
    {
      "volley": #{volley}
    }
    """
    Then the response status should be "201"
  }
end

Given('I have a Volley') do
  steps %Q{
    Given I have a Volley with: '{ "uid": "V1", "name": "joe", "strikes": 100 }'
  }
end

Then(/^the status of the Volley should be '(.*)' and there should be (\d+) results$/) do |status, count|
  steps %Q{
    When I send a GET request to "/api/v1/sieges/S1/volleys/V1"
    Then the response status should be "200"
  }
end

When('if I wait for volley to complete') do
  steps %Q{
    When I send a GET request to "/api/v1/sieges/S1/volleys/V1/wait"
    Then the response status should be "200"
  }
end

