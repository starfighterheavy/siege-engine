# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Results API

  Background:
    Given I have a Siege created
    Given I have a Volley created
    And I have an authenticated JSON API request

  Scenario: Retrieve all Results
    When I send a GET request to "http://0.0.0.0:3000/api/v1/volleys/{volley_id}/results"
    Then the response status should be "200"
