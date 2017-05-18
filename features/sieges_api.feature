# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Siege API

  Background:
    Given I have a Siege
    And I have an authenticated JSON API request

  Scenario: Retrieve a Siege
    When I send a GET request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}"
    Then the response status should be "200"

  Scenario: Get all Sieges
    When I send a GET request to "http://0.0.0.0:3000/api/v1/sieges"
    Then the response status should be "200"

  Scenario: Delete a Siege
    When I send a DELETE request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}"
    Then the response status should be "200"

  Scenario: Update a Siege
    When I set JSON request body to:
    """
    {
      "siege": { "name": "bob" }
    }
    """
    When I send a PATCH request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}"
    Then the response status should be "200"
