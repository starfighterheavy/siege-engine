# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Attackers API

  Background:
    Given I have a Siege
    Given I have an Attacker

  Scenario: Retrieve an Attacker
    When I send a GET request to "/api/v1/sieges/S1/attackers/A1"
    Then the response status should be "200"

  Scenario: Get all Attackers
    When I send a GET request to "/api/v1/sieges/S1/attackers"
    Then the response status should be "200"

  Scenario: Delete a Attacker
    When I send a DELETE request to "/api/v1/sieges/S1/attackers/A1"
    Then the response status should be "200"
    When I send a GET request to "/api/v1/sieges/S1/attackers/A1"
    Then the response status should be "404"

  Scenario: Update a Attacker
    When I send a PATCH request to "/api/v1/sieges/S1/attackers/A1" with the following:
    """
    {
      "attacker": { "username": "bob" }
    }
    """
    Then the response status should be "200"
