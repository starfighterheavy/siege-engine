Given('I have a Report') do
  steps %Q{
    When I set JSON request body to:
    """
    {
      "report": {
        "name": "Test"
      }
    }
    """
    When I send a POST request to "{se_host}/api/v1/volleys/{volley_id}/reports"
    Then the response status should be "200"
    And the JSON response should have key "id"
    And I grab "$..id" as "report_id"
  }
end
