# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Targets API

  Background:
    Given I have a Siege
    Given I have an Attacker
    Given I have a Target

  Scenario: Retrieve an Target
    When I send a GET request to "http://0.0.0.0:3000/api/v1/attackers/{attacker_id}/targets/{target_id}"
    Then the response status should be "200"

  Scenario: Get all Targets
    When I send a GET request to "http://0.0.0.0:3000/api/v1/attackers/{attacker_id}/targets"
    Then the response status should be "200"

  Scenario: Delete a Target
    When I send a DELETE request to "http://0.0.0.0:3000/api/v1/attackers/{attacker_id}/targets/{target_id}"
    Then the response status should be "200"
    When I send a DELETE request to "http://0.0.0.0:3000/api/v1/attackers/{attacker_id}/targets/{target_id}"
    Then the response status should be "404"

  Scenario: Update a Target
    When I set JSON request body to:
    """
    {
      "target": { "url": "bob" }
    }
    """
    When I send a PATCH request to "http://0.0.0.0:3000/api/v1/attackers/{attacker_id}/targets/{target_id}"
    Then the response status should be "200"
