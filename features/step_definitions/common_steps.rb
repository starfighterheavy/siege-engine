Given('I have an authenticated JSON API request') do
  steps %Q{
    Given I send and accept JSON
    And I add Headers:
      | Authorization | Basic MGMyYjczNzEtNTU4MC00YjIzLTlmN2MtNjZhZjA0ZjU3ODgwOmMyYmFiMzY4LWUxOGMtNDE4NC1hMjA4LWM4YTYxNzkwMDNkMg== |
  }
end

Given('I have a Siege created') do
  steps %Q{
    Given I have an authenticated JSON API request
    When I set JSON request body to:
    """
    {
      "siege": { "name": "ted" }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/sieges"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "siege_id"
  }
end

Given('I have a Volley created') do
  steps %Q{
    Given I have a Siege created
    Given I have an authenticated JSON API request
    When I set JSON request body to:
    """
    {
      "volley": { "name": "ted", "strikes": 100 }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "volley_id"
  }
end

Given('I have a Report created') do
  steps %Q{
    Given I have a Volley created
    Given I have an authenticated JSON API request
    When I set JSON request body to:
    """
    {
      "report": {
        "name": "Test"
      }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/reports"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "report_id"
  }
end

Given('I have an Attacker created') do
  steps %Q{
    Given I have a Siege created
    Given I have an authenticated JSON API request
    When I set JSON request body to:
    """
    {
      "attacker": {
        "username": "jskirst@gmail.com",
        "password": "Password1",
        "password_field": "user[password]",
        "username_field": "user[email]",
        "new_session_url": "http://127.0.0.1:3000/users/sign_in",
        "create_session_url": "http://127.0.0.1:3000/users/sign_in"
      }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/attackers"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "attacker_id"
  }
end

Given('I have a Target created') do
  %Q{
    Given I have an Attacker created
    Given I have an authenticated JSON API request
    When I set JSON request body to:
    """
    {
      "target": {
        "url": "http://www.example.com"
      }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/attackers/{attacker_id}/targets"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "target_id"
  }
end
