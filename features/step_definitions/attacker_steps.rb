Given(/^I have an(other)? Attacker$/) do |_other|
  steps %Q{
    Given I have an Attacker with email of 'jskirst@gmail.com' that does not require registration
  }
end

Given(/^I have an Attacker with email of '(.*)'$/) do |email|
  steps %Q{
    Given I have an Attacker with email of '#{email}' that does not require registration
  }
end

Given(/^I have an Attacker that does require registration$/) do
  email = "attacker#{rand(10000000000000)}@example.com"
  steps %Q{
    Given I have an Attacker with email of '#{email}' that does require registration
  }
end

Given(/^I have an Attacker with email of '(.*)' that (.*) require registration$/) do |email, registration|
  registration = registration == 'does'
  password = 'Password1'
  steps %Q{
    When I set JSON request body to:
    """
    {
      "attacker": {
        "username": "#{email}",
        "password": "#{password}",
        "password_field": "user[password]",
        "username_field": "user[email]",
        "new_session_url": "#{@target_host}/users/sign_in",
        "create_session_url": "#{@target_host}/users/sign_in",
        "registration_required": #{registration},
        "new_registration_url": "#{@target_host}/users/sign_up",
        "create_registration_url": "#{@target_host}/users",
        "registration_form_values": "user[email]=#{email}&user[password]=#{password}&user[password_confirmation]=#{password}"
      }
    }
    """
    When I send a POST request to "{se_host}/api/v1/sieges/{siege_id}/attackers"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "attacker_id"
  }
end
