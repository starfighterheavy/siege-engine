# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Volley API
  Background:
    Given I have a Siege
    And I have a Volley with: '{ "uid": "V1", "name": "test", "strikes": 10 }'

  Scenario: Retrieve a Volley
    When I send a GET request to "/api/v1/sieges/S1/volleys/V1"
    Then the response status should be "200"

  Scenario: Get all Volleys
    When I send a GET request to "/api/v1/sieges/S1/volleys"
    Then the response status should be "200"

  Scenario: Delete a Volley
    When I send a DELETE request to "/api/v1/sieges/S1/volleys/V1"
    Then the response status should be "200"
    When I send a GET request to "/api/v1/sieges/S1/volleys/V1"
    Then the response status should be "404"

  Scenario: Update a Volley
    When I send a PATCH request to "/api/v1/sieges/S1/volleys/V1" with the following:
    """
    {
      "volley": { "name": "bob" }
    }
    """
    Then the response status should be "200"

  Scenario: Starting a Volley
    When I send a PATCH request to "/api/v1/sieges/S1/volleys/V1/start"
    Then the response status should be "200"

  Scenario: Canceling a Volley
    When I send a PATCH request to "/api/v1/sieges/S1/volleys/V1/cancel"
    Then the response status should be "200"

  Scenario: Restarting a Volley
    When I send a PATCH request to "/api/v1/sieges/S1/volleys/V1/restart"
    Then the response status should be "200"
