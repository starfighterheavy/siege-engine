When('if I wait for volley to complete') do
  seconds = ENV['WEBMOCK'] == 'false' ? 5 : 0.25
  sleep seconds
end

Then(/^(\w+) should be an array with (\d+) element$/) do |var, size|
  ary = instance_variable_get("@#{var}")
  expect(ary.size).to eq(size.to_i)
end

Then(/the JSON response should have (\d+) elements matching "(.*)"$/) do |count, json_path|
  results = JsonPath.new(resolve(json_path)).on(JSON.parse(@response.body))
  expect(results.count).to eq(count.to_i)
end

Then(/^the previous step execution time should be less than (\d+) ms$/) do |time|
  expect(previous_step_time).to be < time.to_i
end
