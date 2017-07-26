@hello_world
Feature: API is able to respond with "Hello, World!"

  Scenario: Get "Hello, World!" response from API
    When I call 'api.fleshgrinder.docker'
    Then I should get a '"Hello, World!"' response
