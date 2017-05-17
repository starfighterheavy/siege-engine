Given('I have an authenticated JSON API request') do
  steps %Q{
    Given I send and accept JSON
    And I add Headers:
      | Authorization | #{auth_header} |
  }
end

When(/^if I wait for (\d+) seconds$/) do |seconds|
  sleep seconds
end
