# Note: 14 strikes was calculated to evenly distribute the priorities used below
Feature: Run Volley
  Scenario: Run a volley with authenticated and unauthenticated targets
    Given I have a Siege
    Given I have a Volley with: '{ "uid": "V1", "name": "joe", "strikes": 14, "delay": 0 }'
    And I have an Attacker with email of 'attacker1@example.com' and uid 'A1'
    And I have an authenticated Target for the attacker 'A1' with priority of 400 and url of 'http://localhost:3000/secrets/1'
    And I have an authenticated Target for the attacker 'A1' with priority of 200 and url of 'http://localhost:3000/secrets/2'
    And I have an unauthenticated Target for the attacker 'A1' with priority of 100 and url of 'http://localhost:3000/blogs/1'
    And I have an Attacker with email of 'attacker2@example.com' and uid 'A2'
    And I have an authenticated Target for the attacker 'A2' with priority of 400 and url of 'http://localhost:3000/secrets/3'
    And I have an authenticated Target for the attacker 'A2' with priority of 200 and url of 'http://localhost:3000/secrets/4'
    And I have an unauthenticated Target for the attacker 'A2' with priority of 100 and url of 'http://localhost:3000/blogs/2'
    When I send a PATCH request to "/api/v1/sieges/S1/volleys/V1/start"
    Then the response status should be "200"
    And if I wait for volley to complete
    When I send a GET request to "/api/v1/volleys/V1/results"
    Then the response status should be "200"

  Scenario: Run a volley with users requiring registration
    Given I have a Siege
    Given I have a Volley with: '{ "uid": "V1", "name": "joe", "strikes": 7, "delay": 0 }'
    And I have an Attacker that does require registration and uid 'A1'
    And I have an authenticated Target for the attacker 'A1' with priority of 400 and url of 'http://localhost:3000/secrets/1'
    And I have an authenticated Target for the attacker 'A1' with priority of 200 and url of 'http://localhost:3000/secrets/2'
    And I have an unauthenticated Target for the attacker 'A1' with priority of 100 and url of 'http://localhost:3000/blogs/1'
    When I send a PATCH request to "/api/v1/sieges/S1/volleys/V1/start"
    Then the response status should be "200"
    And if I wait for volley to complete
    When I send a GET request to "/api/v1/volleys/V1/results"
    Then the response status should be "200"

  Scenario: Run a volley with stored response body
    Given I have a Siege that stores response body
    And I have a Volley with: '{ "uid": "V1", "name": "joe", "strikes": 1, "delay": 0 }'
    And I have an Attacker with email of 'attacker2@example.com' and uid 'A1'
    And I have an unauthenticated Target for the attacker 'A1' with priority of 100 and url of 'http://localhost:3000/blogs/1'
    When I send a PATCH request to "/api/v1/sieges/S1/volleys/V1/start"
    Then the response status should be "200"
    And if I wait for volley to complete
    When I send a GET request to "/api/v1/volleys/V1/results"
    Then the response status should be "200"
