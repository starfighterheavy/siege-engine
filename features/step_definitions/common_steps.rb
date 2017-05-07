Given(/^I have an authenticated JSON API request$/) do
  steps %Q{
    Given I send and accept JSON
    And I add Headers:
      | Authorization | Basic MGMyYjczNzEtNTU4MC00YjIzLTlmN2MtNjZhZjA0ZjU3ODgwOmMyYmFiMzY4LWUxOGMtNDE4NC1hMjA4LWM4YTYxNzkwMDNkMg== |
  }
end

Given(/^I have a Siege created$/) do
  %Q{
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

Given(/^I have a Volley created$/) do
  %Q{
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
    And I grab "$..id" as "id"
  }
end