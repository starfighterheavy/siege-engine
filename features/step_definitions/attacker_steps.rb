Given(/^I have an(other)? Attacker$/) do |_other|
  #raise 'here'
  steps %Q{
    Given I have an Attacker with email of 'jskirst@gmail.com'
  }
end

Given(/^I have an Attacker with email of '(.*)'$/) do |email|
  steps %Q{
    When I set JSON request body to:
    """
    {
      "attacker": {
        "username": "#{email}",
        "password": "Password1",
        "password_field": "user[password]",
        "username_field": "user[email]",
        "new_session_url": "#{@target_host}/users/sign_in",
        "create_session_url": "#{@target_host}/users/sign_in"
      }
    }
    """
    When I send a POST request to "{se_host}/api/v1/sieges/{siege_id}/attackers"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "attacker_id"
  }
end
