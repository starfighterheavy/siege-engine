# Note: 14 strikes was calculated to evenly distribute the priorities used below
Feature: Run Volley
  Background:
    Given I have a Siege
    Given I have a Volley with: '{ "name": "joe", "strikes": 14 }'
    And I have an authenticated JSON API request

  Scenario: Retrieve a Volley
    Given I have an Attacker
    And I have an authenticated Target for that Attacker with priority of 400 and url of 'http://0.0.0.0:4000/home/1'
    And I have an authenticated Target for that Attacker with priority of 200 and url of 'http://0.0.0.0:4000/home/2'
    And I have an unauthenticated Target for that Attacker with priority of 100 and url of 'http://0.0.0.0:4000/public/1'
    And I have another Attacker
    And I have an authenticated Target for that Attacker with priority of 400 and url of 'http://0.0.0.0:4000/home/3'
    And I have an authenticated Target for that Attacker with priority of 200 and url of 'http://0.0.0.0:4000/home/4'
    And I have an unauthenticated Target for that Attacker with priority of 100 and url of 'http://0.0.0.0:4000/public/2'
    Given I have an authenticated JSON API request
    When I send a PATCH request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys/{volley_id}/start"
    Then the response status should be "200"
    And if I wait for volley to complete
    And the status of the Volley should be 'done' and there should be 14 results
    Given I have an authenticated JSON API request
    When I send a GET request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/results"
    And the response status should be "200"
    And the JSON response should have 14 elements matching "$.results[?(@.code == 200)]"
    And the JSON response should have 4 elements matching "$.results[?(@.target.url == 'http://0.0.0.0:4000/home/1')]"
    And the JSON response should have 2 elements matching "$.results[?(@.target.url == 'http://0.0.0.0:4000/home/2')]"
    And the JSON response should have 1 elements matching "$.results[?(@.target.url == 'http://0.0.0.0:4000/public/1')]"
    And the JSON response should have 4 elements matching "$.results[?(@.target.url == 'http://0.0.0.0:4000/home/3')]"
    And the JSON response should have 2 elements matching "$.results[?(@.target.url == 'http://0.0.0.0:4000/home/4')]"
    And the JSON response should have 1 elements matching "$.results[?(@.target.url == 'http://0.0.0.0:4000/public/2')]"
