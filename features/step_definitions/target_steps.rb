Given(/^I have an (.*) Target for the attacker '(.*)' with priority of (\d+) and url of '(.*)'$/) do |auth, attacker, priority, url|
  auth = auth == 'authenticated'
  steps %Q{
    When I send a POST request to "/api/v1/attackers/#{attacker}/targets" with the following:
    """
    {
      "target": {
        "uid": "T1",
        "url": "#{url}",
        "priority": #{priority},
        "authenticated": #{auth}
      }
    }
    """
    Then the response status should be "201"
  }
end

Given('I have a Target') do
  steps %Q{
    Given I have an unauthenticated Target for the attacker 'A1' with priority of 100 and url of '/api/v1/attackers/A1/targets'
  }
end
