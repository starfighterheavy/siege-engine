Given 'I authenticate myself' do
  unless AccessKey.find_by(access_key_id: ENV['SE_ACCESS_KEY_ID'])
    AccessKey.create!(access_key_id: ENV['SE_ACCESS_KEY_ID'], secret_access_key: ENV['SE_SECRET_ACCESS_KEY'])
  end

  steps %Q{
    Given I authenticate as the user "#{ENV['SE_ACCESS_KEY_ID']}" with the password "#{ENV['SE_SECRET_ACCESS_KEY']}"
  }
end

Given('I have a Siege') do
  steps %Q{
    Given I send and accept JSON
    And I authenticate myself
    When I send a POST request to "/api/v1/sieges" with the following:
    """
    {
      "siege": { "uid": "S1", "name": "teddy", "store_body": false }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    { "uid": "S1", "name": "teddy", "store_body": false, "attackers_count": 0, "targets_count": 0, "volleys": [] }
    """
  }
end

Given('I have a Siege that stores response body') do
  steps %Q{
    Given I send and accept JSON
    And I authenticate myself
    When I send a POST request to "/api/v1/sieges" with the following:
    """
    {
      "siege": { "uid": "S1", "name": "teddy", "store_body": true }
    }
    """
    Then the response status should be "201"
  }
end
