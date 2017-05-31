# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Volley API
  Background:
    Given I have a Siege
    Given I have a Volley with: '{ "name": "test", "strikes": 10 }'

  Scenario: Retrieve a Volley
    When I send a GET request to "{se_host}/api/v1/sieges/{siege_id}/volleys/{volley_id}"
    Then the response status should be "200"
    And the JSON response should have "name" of type string and value "test"
    And the JSON response should have "strikes" of type numeric and value "10"

  Scenario: Get all Volleys
    When I send a GET request to "{se_host}/api/v1/sieges/{siege_id}/volleys"
    Then the response status should be "200"
    When I grab "$..volleys" as "volleys"
    Then volleys should be an array with 1 element

  Scenario: Delete a Volley
    When I send a DELETE request to "{se_host}/api/v1/sieges/{siege_id}/volleys/{volley_id}"
    Then the response status should be "200"
    When I send a GET request to "{se_host}/api/v1/sieges/{siege_id}/volleys/{volley_id}"
    Then the response status should be "404"

  Scenario: Update a Volley
    When I set JSON request body to:
    """
    {
      "volley": { "name": "bob" }
    }
    """
    When I send a PATCH request to "{se_host}/api/v1/sieges/{siege_id}/volleys/{volley_id}"
    Then the response status should be "200"
    And the JSON response should have "name" of type string and value "bob"

  Scenario: Starting a Volley
    When I send a PATCH request to "{se_host}/api/v1/sieges/{siege_id}/volleys/{volley_id}/start"
    Then the response status should be "200"
    And the JSON response should have "status" of type string and value "started"

  Scenario: Canceling a Volley
    When I send a PATCH request to "{se_host}/api/v1/sieges/{siege_id}/volleys/{volley_id}/cancel"
    Then the response status should be "200"
    And the JSON response should have "status" of type string and value "canceled"

  Scenario: Restarting a Volley
    When I send a PATCH request to "{se_host}/api/v1/sieges/{siege_id}/volleys/{volley_id}/restart"
    Then the response status should be "200"
    And the JSON response should have "status" of type string and value "started"
