Given('I have a Report') do
  steps %Q{
    When I send a POST request to "/api/v1/volleys/V1/reports" with the following:
    """
    {
      "report": {
        "uid": "R1",
        "name": "Test"
      }
    }
    """
    Then the response status should be "201"
  }
end
