# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Reports API

  Background:
    Given I have a Report created
    And I have an authenticated JSON API request

  Scenario: Retrieve an Report
    When I send a GET request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/reports/{report_id}"
    Then the response status should be "200"

  Scenario: Get all Reports
    When I send a GET request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/reports"
    Then the response status should be "200"

  Scenario: Delete a Report
    When I send a DELETE request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/reports/{report_id}"
    Then the response status should be "200"

  Scenario: Update a Report
    When I set JSON request body to:
    """
    {
      "report": { "name": "bob" }
    }
    """
    When I send a PATCH request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/reports/{report_id}"
    Then the response status should be "200"
