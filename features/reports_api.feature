# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Reports API

  Background:
    Given I send and accept JSON
    And I add Headers:
      | Authorization | Basic MGMyYjczNzEtNTU4MC00YjIzLTlmN2MtNjZhZjA0ZjU3ODgwOmMyYmFiMzY4LWUxOGMtNDE4NC1hMjA4LWM4YTYxNzkwMDNkMg== |
    When I set JSON request body to:
    """
    {
      "siege": { "name": "ted" }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/sieges"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "siege_id"
    Given I send and accept JSON
    And I add Headers:
      | Authorization | Basic MGMyYjczNzEtNTU4MC00YjIzLTlmN2MtNjZhZjA0ZjU3ODgwOmMyYmFiMzY4LWUxOGMtNDE4NC1hMjA4LWM4YTYxNzkwMDNkMg== |
    When I set JSON request body to:
    """
    {
      "volley": {
        "name": "jskirst@gmail.com"
      }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/volleys"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "volley_id"
    Given I send and accept JSON
    And I add Headers:
      | Authorization | Basic MGMyYjczNzEtNTU4MC00YjIzLTlmN2MtNjZhZjA0ZjU3ODgwOmMyYmFiMzY4LWUxOGMtNDE4NC1hMjA4LWM4YTYxNzkwMDNkMg== |
    When I set JSON request body to:
    """
    {
      "report": {
        "name": "Test"
      }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/reports"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "id"
    Given I send and accept JSON
    And I add Headers:
      | Authorization | Basic MGMyYjczNzEtNTU4MC00YjIzLTlmN2MtNjZhZjA0ZjU3ODgwOmMyYmFiMzY4LWUxOGMtNDE4NC1hMjA4LWM4YTYxNzkwMDNkMg== |

  Scenario: Retrieve an Report
    When I send a GET request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/reports/{id}"
    Then the response status should be "200"

  Scenario: Get all Reports
    When I send a GET request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/reports"
    Then the response status should be "200"

  Scenario: Delete a Report
    When I send a DELETE request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/reports/{id}"
    Then the response status should be "200"

  Scenario: Update a Report
    When I set JSON request body to:
    """
    {
      "report": { "name": "bob" }
    }
    """
    When I send a PATCH request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/reports/{id}"
    Then the response status should be "200"