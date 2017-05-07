# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Volley API
  Background:
    Given I have a Volley created
    And I have an authenticated JSON API request

  Scenario: Retrieve a Volley
    When I send a GET request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys/{volley_id}"
    Then the response status should be "200"

  Scenario: Get all Volleys
    When I send a GET request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys"
    Then the response status should be "200"

  Scenario: Delete a Volley
    When I send a DELETE request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys/{volley_id}"
    Then the response status should be "200"

  Scenario: Update a Volley
    When I set JSON request body to:
    """
    {
      "volley": { "name": "bob" }
    }
    """
    When I send a PATCH request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys/{volley_id}"
    Then the response status should be "200"
