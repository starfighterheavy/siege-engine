# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Attackers API

  Background:
    Given I have a Siege
    Given I have an Attacker
    Given I have an authenticated JSON API request

  Scenario: Retrieve an Attacker
    When I send a GET request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/attackers/{attacker_id}"
    Then the response status should be "200"

  Scenario: Get all Attackers
    When I send a GET request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/attackers"
    Then the response status should be "200"

  Scenario: Delete a Attacker
    When I send a DELETE request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/attackers/{attacker_id}"
    Then the response status should be "200"

  Scenario: Update a Attacker
    When I set JSON request body to:
    """
    {
      "attacker": { "username": "bob" }
    }
    """
    When I send a PATCH request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/attackers/{attacker_id}"
    Then the response status should be "200"
