# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Run Volley
  Background:
    Given I have a Siege created
    Given I have a Volley created with 14 strikes
    And I have an authenticated JSON API request

  Scenario: Retrieve a Volley
    Given I have an Attacker created
    And I have an authenticated Target for that Attacker with priority of 400 and url of 'http://0.0.0.0:4000/home/1'
    And I have an authenticated Target for that Attacker with priority of 200 and url of 'http://0.0.0.0:4000/home/2'
    And I have a Target for that Attacker with priority of 100 and url of 'http://0.0.0.0:4000/public/1'
    And I have another Attacker created
    And I have an authenticated Target for that Attacker with priority of 400 and url of 'http://0.0.0.0:4000/home/3'
    And I have an authenticated Target for that Attacker with priority of 200 and url of 'http://0.0.0.0:4000/home/4'
    And I have a Target for that Attacker with priority of 100 and url of 'http://0.0.0.0:4000/public/2'
    When I send a PATCH request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys/{volley_id}/start"
    Then the response status should be "200"
    And if I wait for 20 seconds
    Then the status of the Volley should be 'done' and there should be 14 results
    Then I expect to see 4 results for Target with url 'http://0.0.0.0:4000/home/1'
    Then I expect to see 2 results for Target with url 'http://0.0.0.0:4000/home/2'
    Then I expect to see 1 results for Target with url 'http://0.0.0.0:4000/public/1'
    Then I expect to see 4 results for Target with url 'http://0.0.0.0:4000/home/3'
    Then I expect to see 2 results for Target with url 'http://0.0.0.0:4000/home/4'
    Then I expect to see 1 results for Target with url 'http://0.0.0.0:4000/public/2'
