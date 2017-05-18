Given(/I have an(other)? Attacker/) do |_other|
  steps %Q{
    Given I have an authenticated JSON API request
    When I set JSON request body to:
    """
    {
      "attacker": {
        "username": "jskirst@gmail.com",
        "password": "Password1",
        "password_field": "user[password]",
        "username_field": "user[email]",
        "new_session_url": "http://127.0.0.1:3000/users/sign_in",
        "create_session_url": "http://127.0.0.1:3000/users/sign_in"
      }
    }
    """
    When I send a POST request to "http://0.0.0.0:3000/api/v1/sieges/{siege_id}/attackers"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "attacker_id"
  }
end
