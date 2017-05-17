Given('I have an authenticated JSON API request') do
  steps %Q{
    Given I send and accept JSON
    And I add Headers:
      | Authorization | #{auth_header} |
  }
end

When('if I wait for volley to complete') do
  seconds = ENV['WEBMOCK'] == 'false' ? 5 : 0.25
  sleep seconds
end

Then(/the JSON response should have (\d+) elements matching "(.*)"$/) do |count, json_path|
  results = JsonPath.new(json_path).on(JSON.parse(@response.body))
  expect(results.count).to eq(count.to_i)
end

Then(/^the previous step execution time should be less than (\d+) ms$/) do |time|
  expect(previous_step_time).to be < time.to_i
end
