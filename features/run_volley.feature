# Note: 14 strikes was calculated to evenly distribute the priorities used below
Feature: Run Volley
  Background:
    Given I have a Siege

  Scenario: Run a volley with authenticated and unauthenticated targets
    Given I have a Volley with: '{ "name": "joe", "strikes": 14, "delay": 0 }'
    And I have an Attacker with email of 'attacker1@example.com'
    And I have an authenticated Target for that Attacker with priority of 400 and url of '{target_host}/home/1'
    And I have an authenticated Target for that Attacker with priority of 200 and url of '{target_host}/home/2'
    And I have an unauthenticated Target for that Attacker with priority of 100 and url of '{target_host}/public/1'
    And I have an Attacker with email of 'attacker2@example.com'
    And I have an authenticated Target for that Attacker with priority of 400 and url of '{target_host}/home/3'
    And I have an authenticated Target for that Attacker with priority of 200 and url of '{target_host}/home/4'
    And I have an unauthenticated Target for that Attacker with priority of 100 and url of '{target_host}/public/2'
    When I send a PATCH request to "{se_host}/api/v1/sieges/{siege_id}/volleys/{volley_id}/start"
    Then the response status should be "200"
    And if I wait for volley to complete
    And the status of the Volley should be 'done' and there should be 14 results
    When I send a GET request to "{se_host}/api/v1/volleys/{volley_id}/results"
    Then the response status should be "200"
    And the JSON response should have 14 elements matching "$.results[?(@.code == 200)]"
    And the JSON response should have 4 elements matching "$.results[?(@.target.url == '{target_host}/home/1')]"
    And the JSON response should have 2 elements matching "$.results[?(@.target.url == '{target_host}/home/2')]"
    And the JSON response should have 1 elements matching "$.results[?(@.target.url == '{target_host}/public/1')]"
    And the JSON response should have 4 elements matching "$.results[?(@.target.url == '{target_host}/home/3')]"
    And the JSON response should have 2 elements matching "$.results[?(@.target.url == '{target_host}/home/4')]"
    And the JSON response should have 1 elements matching "$.results[?(@.target.url == '{target_host}/public/2')]"

  Scenario: Run a volley with users requiring registration
    Given I have a Volley with: '{ "name": "joe", "strikes": 7, "delay": 0 }'
    And I have an Attacker that does require registration
    And I have an authenticated Target for that Attacker with priority of 400 and url of '{target_host}/home/1'
    And I have an authenticated Target for that Attacker with priority of 200 and url of '{target_host}/home/2'
    And I have an unauthenticated Target for that Attacker with priority of 100 and url of '{target_host}/public/1'
    When I send a PATCH request to "{se_host}/api/v1/sieges/{siege_id}/volleys/{volley_id}/start"
    Then the response status should be "200"
    And if I wait for volley to complete
    And the status of the Volley should be 'done' and there should be 7 results
    When I send a GET request to "{se_host}/api/v1/volleys/{volley_id}/results"
    Then the response status should be "200"
    And the JSON response should have 7 elements matching "$.results[?(@.code == 200)]"
    And the JSON response should have 4 elements matching "$.results[?(@.target.url == '{target_host}/home/1')]"
    And the JSON response should have 2 elements matching "$.results[?(@.target.url == '{target_host}/home/2')]"
    And the JSON response should have 1 elements matching "$.results[?(@.target.url == '{target_host}/public/1')]"

