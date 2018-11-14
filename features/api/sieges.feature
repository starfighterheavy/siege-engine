# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Siege API

  Background:
    Given I have a Siege
    And I send and accept JSON
    And I authenticate myself

  Scenario: Retrieve a Siege
    When I send a GET request to "/api/v1/sieges/S1"
    Then the response status should be "200"

  Scenario: Get all Sieges
    When I send a GET request to "/api/v1/sieges"
    Then the response status should be "200"

  Scenario: Delete a Siege
    When I send a DELETE request to "/api/v1/sieges/S1"
    Then the response status should be "200"

  Scenario: Update a Siege
    When I send a PATCH request to "/api/v1/sieges/S1" with the following:
    """
    {
      "siege": { "name": "bob", "store_body": false }
    }
    """
    Then the response status should be "200"
