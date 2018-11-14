# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Reports API

  Background:
    Given I have a Siege
    Given I have a Volley
    Given I have a Report

  Scenario: Retrieve an Report
    When I send a GET request to "/api/v1/volleys/V1/reports/R1"
    Then the response status should be "200"

  Scenario: Get all Reports
    When I send a GET request to "/api/v1/volleys/V1/reports"
    Then the response status should be "200"

  Scenario: Delete a Report
    When I send a DELETE request to "/api/v1/volleys/V1/reports/R1"
    Then the response status should be "200"

  Scenario: Update a Report
    When I send a PATCH request to "/api/v1/volleys/V1/reports/R1" with the following:
    """
    {
      "report": { "name": "bob" }
    }
    """
    Then the response status should be "200"
