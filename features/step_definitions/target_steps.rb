Given(/^I have an (.*) Target for that Attacker with priority of (\d+) and url of '(.*)'$/) do |auth, priority, url|
  auth = auth == 'authenticated'
  steps %Q{
    Given I have an authenticated JSON API request
    When I set JSON request body to:
    """
    {
      "target": {
        "url": "#{url}",
        "priority": #{priority},
        "authenticated": #{auth}
      }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/attackers/{attacker_id}/targets"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "target_id"
  }
end

Given('I have a Target created') do
  steps %Q{
    Given I have an unauthenticated Target for that Attacker with priority of 100 and url of 'http://0.0.0.0:3000/api/v1/attackers/{attacker_id}/targets'
  }
end