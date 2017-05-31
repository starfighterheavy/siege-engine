Given('I have a Siege') do
  steps %Q{
    When I set JSON request body to:
    """
    {
      "siege": { "name": "teddy" }
    }
    """
    When I send a POST request to "{se_host}/api/v1/sieges"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "siege_id"
  }
end
