# TODO - Expand checks of index count, show values, update values and delete presence check
Feature: Results API

  Background:
    Given I have a Siege
    Given I have a Volley

  Scenario: Retrieve all Results
    When I send a GET request to "{se_host}/api/v1/volleys/{volley_id}/results"
    Then the response status should be "200"
