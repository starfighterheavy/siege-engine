Given(/^I have an(other)? Attacker$/) do |_other|
  steps %Q{
    Given I have an Attacker with email of 'jskirst@gmail.com' and uid 'A1' that does not require registration
  }
end

Given(/^I have an Attacker with email of '(.*)' and uid '(.*)'$/) do |email, uid|
  steps %Q{
    Given I have an Attacker with email of '#{email}' and uid '#{uid}' that does not require registration
  }
end

Given(/^I have an Attacker that does require registration and uid '(.*)'$/) do |uid|
  email = "attacker#{rand(10000000000000)}@example.com"
  steps %Q{
    Given I have an Attacker with email of '#{email}' and uid '#{uid}' that does require registration
  }
end

Given(/^I have an Attacker with email of '(.*)' and uid '(.*)' that (.*) require registration$/) do |email, uid, registration|
  registration = registration == 'does'
  password = 'Password1'
  steps %Q{
    When I send a POST request to "/api/v1/sieges/S1/attackers" with the following:
    """
    {
      "attacker": {
        "uid": "#{uid}",
        "username": "#{email}",
        "password": "#{password}",
        "password_field": "user[password]",
        "username_field": "user[email]",
        "new_session_url": "/test/users/sign_in",
        "create_session_url": "/test/users/sign_in",
        "registration_required": #{registration},
        "new_registration_url": "/test/users/sign_up",
        "create_registration_url": "/test/users",
        "registration_form_values": "user[email]=#{email}&user[password]=#{password}&user[password_confirmation]=#{password}"
      }
    }
    """
    Then the response status should be "201"
  }
end
