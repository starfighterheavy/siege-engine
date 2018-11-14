# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Targets API

  Background:
    Given I have a Siege
    Given I have an Attacker
    Given I have a Target

  Scenario: Retrieve an Target
    When I send a GET request to "/api/v1/attackers/A1/targets/T1"
    Then the response status should be "200"

  Scenario: Get all Targets
    When I send a GET request to "/api/v1/attackers/A1/targets"
    Then the response status should be "200"

  Scenario: Delete a Target
    When I send a DELETE request to "/api/v1/attackers/A1/targets/T1"
    Then the response status should be "200"
    When I send a DELETE request to "/api/v1/attackers/A1/targets/T1"
    Then the response status should be "404"

  Scenario: Update a Target
    When I send a PATCH request to "/api/v1/attackers/A1/targets/T1" with the following:
    """
    {
      "target": { "url": "bob" }
    }
    """
    Then the response status should be "200"
